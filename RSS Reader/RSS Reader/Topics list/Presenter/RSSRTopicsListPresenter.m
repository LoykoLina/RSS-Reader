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

@property (nonatomic, retain) RSSRNetworkService *service;
@property (nonatomic, retain) RSSRXMLParser *parser;

@end

@implementation RSSRTopicsListPresenter

static NSString * const baseURLString = @"http://news.tut.by/rss/index.rss";

- (instancetype)initWithService:(RSSRNetworkService *)service parser:(RSSRXMLParser *)parser {
    self = [super init];
    if (self) {
        _service = [service retain];
        _parser = [parser retain];
    }
    return self;
}

- (void)loadTopics {
    __block typeof(self) weakSelf = self;
    [self.service loadTopicsFromURL:[NSURL URLWithString:baseURLString]
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
        if (error) {
            [weakSelf showError:error];
        } else {
            [weakSelf.topicsListView setTopics:topics];
        }
    }];
}

- (void)showError:(NSError *)error {
    [self.topicsListView showAlertControllerWithTitle:@"Error" message:error.localizedDescription];
}

- (void)dealloc {
    [_service release];
    [_parser release];
    [super dealloc];
}

@end
