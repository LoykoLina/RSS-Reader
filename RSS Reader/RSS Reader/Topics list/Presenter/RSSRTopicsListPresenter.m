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

@interface RSSRTopicsListPresenter ()

@property (nonatomic, retain) RSSRNetworkService *service;

@end

@implementation RSSRTopicsListPresenter

static NSString * const baseURLString = @"http://news.tut.by/rss/index.rss";

- (instancetype)initWithService:(RSSRNetworkService *)service {
    self = [super init];
    if (self) {
        _service = [service retain];
    }
    return self;
}

- (void)loadTopics {
    __block typeof(self) weakSelf = self;
    [self.service loadTopicsFromURL:[NSURL URLWithString:baseURLString]
                         completion:^(NSMutableArray<RSSRTopic *> *topics, NSError *error) {
        if (error) {
            [weakSelf.topicsListView showAlertControllerWithTitle:@"Error" message:error.localizedDescription];
        } else {
            [weakSelf.topicsListView setTopics:topics];
        }
    }];
}

- (void)dealloc {
    [_service release];
    [super dealloc];
}

@end
