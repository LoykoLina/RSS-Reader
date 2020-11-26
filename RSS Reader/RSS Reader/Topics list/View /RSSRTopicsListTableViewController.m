//
//  RSSRTopicsListTableViewController.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopicsListTableViewController.h"
#import "RSSRTopic.h"
#import "RSSRTopicsListPresenter.h"
#import "RSSRTopicTableViewCell.h"

static NSString * const kReuseIdentifier = @"RSSRTopicTableViewCell";
static NSString * const kTitle = @"TUT.by News";

@interface RSSRTopicsListTableViewController ()

@property (nonatomic, retain) RSSRTopicsListPresenter *presenter;

@end

@implementation RSSRTopicsListTableViewController

- (instancetype)initWithPresenter:(RSSRTopicsListPresenter *)presenter {
    self = [super init];
    if (self) {
        _presenter = [presenter retain];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.title = kTitle;
    self.navigationController.title = self.title;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setHidesBarsOnSwipe:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:kReuseIdentifier bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
    
    self.presenter.topicsListView = self;
    [self.presenter loadTopics];
}

- (void)dealloc {
    [_presenter release];
    [super dealloc];
}

- (BOOL)prefersStatusBarHidden {
    return self.navigationController.navigationBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.navigationController.navigationBarHidden ? UIStatusBarAnimationSlide : UIStatusBarAnimationFade;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter getTopics].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSRTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    [cell configureWithItem:[self.presenter getTopics][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *link = [[self.presenter getTopics][indexPath.row] itemLink];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: link]
                                       options:@{}
                             completionHandler:nil];
}


#pragma mark - RSSRTopicsListView Protocol

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end





