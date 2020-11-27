//
//  RSSFeedPresenter.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/27/20.
//

#import <Foundation/Foundation.h>
#import "AlertPresentable.h"

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopic;

@protocol RSSFeedPresenter <NSObject>

- (void)loadTopics;
- (void)attachView:(id<RSSFeedView, AlertPresentable>)view;
- (NSArray<RSSRTopic *> *)topics;

@end

NS_ASSUME_NONNULL_END
