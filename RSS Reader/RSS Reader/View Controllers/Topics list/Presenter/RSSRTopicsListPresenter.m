//
//  RSSRTopicsListPresenter.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/18/20.
//

#import <UIKit/UIKit.h>
#import "RSSRTopicsListPresenter.h"
#import "RSSRTopic.h"
#import "RSSRNetworkService.h"
#import "RSSRFeedParser.h"
#import "UIViewController+ViewControllerPresentable.h"
#import "NSError+ErrorParsing.h"
#import "RSSRWebBrowserController.h"
#import "RSSRSettingsController.h"
#import "RSSRSettingsPresenter.h"
#import "RSSRFeedService.h"


@interface RSSRTopicsListPresenter ()

@property (nonatomic, assign) id<RSSFeedView, ViewControllerPresentable> feedView;

@property (nonatomic) RSSRNetworkService *networkService;
@property (nonatomic) RSSRFeedParser *parser;
@property (nonatomic) RSSRFileService *fileService;

@property (nonatomic) NSArray<RSSRTopic *> *dataSource;
@property (nonatomic) RSSRChannel *channel;

@end

@implementation RSSRTopicsListPresenter


#pragma mark -  Initialization

- (instancetype)initWithService:(RSSRNetworkService *)service
                         parser:(RSSRFeedParser *)parser
                    fileService:(RSSRFileService *)fileService {
    self = [super init];
    if (self) {
        _networkService = service;
        _parser = parser;
        _fileService = fileService;
    }
    return self;
}



- (void)parseTopicsData:(NSData *)data {
    __block typeof(self) weakSelf = self;
    [self.parser parseTopics:data completion:^(NSMutableArray<RSSRTopic *> *topics, NSError *error) {
        if (error) {
            [weakSelf showError:error];
        } else {
            weakSelf.dataSource = topics;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.feedView endRefreshing];
                [self.feedView stopActivityIndicator];
                [self.feedView reloadData];
            });
        }
    }];
}

- (void)showError:(NSError *)error {
    [error parseErrorWithCompletion:^(NSString *title, NSString *message) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.feedView endRefreshing];
            [self.feedView stopActivityIndicator];
            [self.feedView showAlertWithTitle:title message:message];
        });
    }];
}


#pragma mark - RSSRFeedPresenter Protocol

- (void)loadTopics {
    __block typeof(self) weakSelf = self;
    [self.fileService loadChannel:^(RSSRChannel *channel, NSError *error) {
        if (error) {
            [weakSelf showError:error];
            
        } else if (channel && ![channel.link isEqual:weakSelf.channel.link]) {
            weakSelf.channel = channel;
            weakSelf.dataSource = nil;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.feedView reloadData];
            });
            
            [weakSelf.networkService loadDataFromURL:[NSURL URLWithString:weakSelf.channel.link]
                                      completion:^(NSData *data, NSError *error) {
                if (error) {
                    [weakSelf showError:error];
                } else {
                    [weakSelf parseTopicsData:data];
                }
            }];
        } else {
            if (!channel) {
                weakSelf.channel = nil;
                weakSelf.dataSource = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.feedView reloadData];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.feedView endRefreshing];
                [self.feedView stopActivityIndicator];
            });
        }
    }];
}

- (void)refreshTopics {
    if (self.channel) {
        __block typeof(self) weakSelf = self;
        [self.networkService loadDataFromURL:[NSURL URLWithString:self.channel.link]
                                  completion:^(NSData *data, NSError *error) {
            if (error) {
                [weakSelf showError:error];
            } else {
                [weakSelf parseTopicsData:data];
            }
        }];
    }
}

- (NSArray<RSSRTopic *> *)topics {
    return self.dataSource;
}

- (void)attachView:(id<RSSFeedView, ViewControllerPresentable>)view {
    self.feedView = view;
}

- (void)showTopicAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *link = [self.dataSource[indexPath.row] itemLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
    
    RSSRWebBrowserController *webBrowser = [[RSSRWebBrowserController alloc] initWithURLRequest:request];
    [self.feedView pushViewController:webBrowser];
}

- (void)openFeedsSettings {
    RSSRFeedService *feedService = [RSSRFeedService new];
    RSSRSettingsPresenter *presenter = [[RSSRSettingsPresenter alloc] initWithFeedService:feedService
                                                                           networkService:self.networkService
                                                                              fileService:self.fileService];
    RSSRSettingsController *settingsController = [[RSSRSettingsController alloc] initWithPresenter:presenter
                                                                                           channel:self.channel];
    
    [self.feedView pushViewController:settingsController];
}

@end
