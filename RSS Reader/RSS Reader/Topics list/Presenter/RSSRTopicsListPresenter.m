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
#import "UIViewController+AlertPresentable.h"

@interface RSSRTopicsListPresenter ()

@property (nonatomic, assign) id<RSSFeedView, AlertPresentable> feedView;
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.feedView endRefreshing];
        [self.feedView stopActivityIndicator];
        [self.feedView showAlertWithTitle:@"Error" message:error.localizedDescription];
    });
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

- (void)attachView:(id<RSSFeedView, AlertPresentable>)view {
    self.feedView = view;
}

@end
