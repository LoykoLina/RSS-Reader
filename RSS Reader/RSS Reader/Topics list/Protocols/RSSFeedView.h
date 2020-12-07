//
//  RSSFeedView.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/18/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopic;

@protocol RSSFeedView <NSObject>

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
