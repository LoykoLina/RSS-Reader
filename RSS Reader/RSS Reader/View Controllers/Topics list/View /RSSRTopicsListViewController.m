//
//  RSSRTopicsListViewController.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopicsListViewController.h"
#import "RSSRTopic.h"
#import "RSSRTopicsListPresenter.h"
#import "RSSRTopicTableViewCell.h"
#import "RSSFeedPresenter.h"
#import "UIViewController+AlertPresentable.h"
#import "UIColor+RSSRColor.h"
#import "RSSRTopicCellDelegate.h"

static NSString * const kReuseIdentifier = @"RSSRTopicTableViewCell";
static NSString * const kTitle = @"TUT.by News";

@interface RSSRTopicsListViewController () <UITableViewDataSource, UITableViewDelegate, RSSRTopicCellDelegate>

@property (nonatomic, retain) id<RSSFeedPresenter> presenter;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end

@implementation RSSRTopicsListViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColor.RSSRBackgroundColor;
        _tableView.backgroundView = self.activityIndicator;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNib:[UINib nibWithNibName:kReuseIdentifier bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [UIActivityIndicatorView new];
    }
    return _activityIndicator;
}

- (instancetype)initWithPresenter:(id<RSSFeedPresenter>)presenter {
    self = [super init];
    if (self) {
        _presenter = [presenter retain];
        [_presenter attachView:self];
    }
    return self;
}

- (void)dealloc {
    [_presenter release];
    [_tableView release];
    [_activityIndicator release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupConstraints];
    [self setupNavigationController];
    [self configureRefreshControl];
    
    [self.activityIndicator startAnimating];
    [self.presenter loadTopics];
}


#pragma mark - Navigation controller configuration

- (void)setupNavigationController {
    self.title = kTitle;
    self.navigationController.title = self.title;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setHidesBarsOnSwipe:YES];
}


#pragma mark - Constraints setup

- (void)setupConstraints {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
         [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
         [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
         [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
         [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
}


#pragma mark - Refresh control configuration

- (void)configureRefreshControl {
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self.presenter
                       action:@selector(loadTopics)
             forControlEvents:UIControlEventValueChanged];
    refreshControl.layer.zPosition = -1;
    
    self.tableView.refreshControl = refreshControl;
    [refreshControl release];
}


#pragma mark - Status bar configuration

- (BOOL)prefersStatusBarHidden {
    return self.navigationController.navigationBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.navigationController.navigationBarHidden ? UIStatusBarAnimationSlide : UIStatusBarAnimationFade;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter topics].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSRTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    [cell configureWithItem:[self.presenter topics][indexPath.row]
                   delegate:self];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *link = [[self.presenter topics][indexPath.row] itemLink];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: link]
                                       options:@{}
                             completionHandler:nil];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


#pragma mark - RSSRTopicsListView Protocol

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)stopActivityIndicator {
    [self.activityIndicator stopAnimating];
}

- (void)endRefreshing {
    [self.tableView.refreshControl endRefreshing];
}


#pragma mark - RSSRTopicCellDelegate Protocol

- (void)reloadCellWithTopic:(id<RSSRTopicItemProtocol>)topic {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[self.presenter topics] indexOfObject:topic] inSection:0];
    
    [UIView performWithoutAnimation:^{
            [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
    }];
}

@end





