//
//  RSSRTopicTableViewCell.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopic;

@interface RSSRTopicTableViewCell : UITableViewCell

- (void)configureWithItem:(RSSRTopic *)topic;

@end

NS_ASSUME_NONNULL_END
