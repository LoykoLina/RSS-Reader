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
#import "RSSRNetworkService.h"
#import "RSSRXMLParser.h"

static NSString * const kReuseIdentifier = @"RSSRTopicTableViewCell";
static NSString * const kTitle = @"TUT.by News";

@interface RSSRTopicsListTableViewController ()

@property (nonatomic, retain) RSSRTopicsListPresenter *presenter;
@property (nonatomic, retain) NSMutableArray<RSSRTopic *> *dataSource;

@end

@implementation RSSRTopicsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.title = kTitle;
    self.navigationController.title = self.title;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setHidesBarsOnSwipe:YES];
    
    [self.tableView registerNib:[UINib nibWithNibName:kReuseIdentifier bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
    
    
    RSSRXMLParser *parser = [RSSRXMLParser new];
    RSSRNetworkService *service = [[RSSRNetworkService alloc] initWithParser:parser];
    [parser release];
    
    self.presenter = [[RSSRTopicsListPresenter alloc] initWithService:service];
    self.presenter.topicsListView = self;
    
    [service release];
    
    [self.presenter loadTopics];
}

- (void)dealloc {
    [_dataSource release];
    [_presenter release];
    [super dealloc];
}

- (BOOL)prefersStatusBarHidden {
    return self.navigationController.navigationBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    if (self.navigationController.navigationBarHidden) {
        return UIStatusBarAnimationSlide;
    } else {
        return UIStatusBarAnimationFade;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSRTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];

    [cell configureWithItem:self.dataSource[indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.dataSource[indexPath.row].link]
                                       options:@{}
                             completionHandler:nil];
}


#pragma mark - RSSRTopicsListView Protocol

- (void)setTopics:(NSMutableArray<RSSRTopic *> *)topics {
    self.dataSource = topics;
    __block typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message; {
    __block typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil]];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    });
}


@end





