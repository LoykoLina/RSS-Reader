//
//  RSSRTopicCellDelegate.h
//  RSS Reader
//
//  Created by Lina Loyko on 2/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSSRTopicCellDelegate <NSObject>

- (void)reloadCellWithTopic:(id<RSSRTopicItemProtocol>)topic;

@end

NS_ASSUME_NONNULL_END
