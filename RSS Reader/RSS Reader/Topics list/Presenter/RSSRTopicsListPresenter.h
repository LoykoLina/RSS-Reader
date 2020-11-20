//
//  RSSRTopicsListPresenter.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/18/20.
//

#import <Foundation/Foundation.h>
#import "RSSRTopicsListView.h"

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopic;
@class RSSRNetworkService;

@interface RSSRTopicsListPresenter : NSObject

@property (nonatomic, assign) id<RSSRTopicsListView> topicsListView;

- (instancetype)initWithService:(RSSRNetworkService *)service;
- (void)loadTopics;

@end

NS_ASSUME_NONNULL_END
