//
//  RSSFeedPresenter.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/27/20.
//

#import <Foundation/Foundation.h>
#import "ViewControllerPresentable.h"

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopic;

@protocol RSSFeedPresenter <NSObject>

- (void)loadTopics;
- (void)refreshTopics;
- (NSArray<RSSRTopic *> *)topics;

- (void)attachView:(id<RSSFeedView, ViewControllerPresentable>)view;
- (void)showTopicAtIndexPath:(NSIndexPath *)indexPath;

- (void)openFeedsSettings;

@end

NS_ASSUME_NONNULL_END
