//
//  RSSRSettingsView.h
//  RSS Reader
//
//  Created by Lina Loyko on 1/8/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RSSRChannel;

@protocol RSSFeedsSettingsView <NSObject>

- (void)hideActivitiIndicator;
- (void)displayFeedsOptions:(NSArray<RSSRChannel *> *)channels;
- (void)displayAddedFeed:(RSSRChannel *)channel;
- (void)hideAddedFeed;

@end

NS_ASSUME_NONNULL_END
