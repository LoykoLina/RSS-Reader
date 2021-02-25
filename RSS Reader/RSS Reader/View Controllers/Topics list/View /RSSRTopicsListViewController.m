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
#import "UIViewController+ViewControllerPresentable.h"
#import "UIColor+RSSRColor.h"
#import "RSSRTopicCellDelegate.h"

static NSString * const kReuseIdentifier = @"RSSRTopicTableViewCell";
static NSString * const kTitle = @"TUT.by News";

@interface RSSRTopicsListViewController () <UITableViewDataSource, UITableViewDelegate, RSSRTopicCellDelegate>

@property (nonatomic, retain) id<RSSFeedPresenter> presenter;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@property (nonatomic) CGFloat lastContentOffset;

@end

@implementation RSSRTopicsListViewController


#pragma mark - Lazy properties

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


#pragma mark - Initialization & Deallocation

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


#pragma mark - View controller life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kTitle;
    
    [self setupConstraints];
    [self configureRefreshControl];
    
    [self.activityIndicator startAnimating];
    [self.presenter loadTopics];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:YES];
}


#pragma mark - Hide/show navigationbar

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= self.lastContentOffset) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else if ([self.presenter topics].count) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
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
    
    [self.presenter showTopicAtIndexPath:indexPath];
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





