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
#import "RSSRXMLParser.h"
#import "UIViewController+ViewControllerPresentable.h"
#import "NSError+ErrorParsing.h"
#import "RSSRWebBrowserController.h"

@interface RSSRTopicsListPresenter ()

@property (nonatomic, assign) id<RSSFeedView, ViewControllerPresentable> feedView;
@property (nonatomic, retain) RSSRNetworkService *networkService;
@property (nonatomic, retain) RSSRXMLParser *parser;
@property (nonatomic, retain) NSArray<RSSRTopic *> *dataSource;

@end

@implementation RSSRTopicsListPresenter

static NSString * const baseURLString = @"http://news.tut.by/rss/index.rss";

- (instancetype)initWithService:(RSSRNetworkService *)service parser:(RSSRXMLParser *)parser {
    self = [super init];
    if (self) {
        _networkService = [service retain];
        _parser = [parser retain];
    }
    return self;
}

- (void)dealloc {
    [_networkService release];
    [_parser release];
    [_dataSource release];
    [super dealloc];
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
    [self.networkService loadDataFromURL:[NSURL URLWithString:baseURLString]
                         completion:^(NSData *data, NSError *error) {
        if (error) {
            [weakSelf showError:error];
        } else {
            [weakSelf parseTopicsData:data];
        }
    }];
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
    [webBrowser release];
}

@end
