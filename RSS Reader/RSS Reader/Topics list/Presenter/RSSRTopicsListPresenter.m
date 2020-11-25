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

@interface RSSRTopicsListPresenter ()

@property (nonatomic, retain) RSSRNetworkService *networkService;
@property (nonatomic, retain) RSSRXMLParser *parser;
@property (nonatomic, retain) NSMutableArray<RSSRTopic *> *dataSource;

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

- (void)parseTopicsData:(NSData *)data {
    __block typeof(self) weakSelf = self;
    [self.parser parseTopics:data completion:^(NSMutableArray<RSSRTopic *> *topics, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [weakSelf showError:error];
            } else {
                weakSelf.dataSource = topics;
                [weakSelf.topicsListView reloadData];
            }
        });
    }];
}

- (void)showError:(NSError *)error {
    [self.topicsListView showAlertControllerWithTitle:@"Error" message:error.localizedDescription];
}

- (NSArray<RSSRTopic *> *)getTopics {
    return self.dataSource;
}

- (void)dealloc {
    [_networkService release];
    [_parser release];
    [_dataSource release];
    [super dealloc];
}

@end
