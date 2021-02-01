//
//  RSSRTopicTableViewCell.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <UIKit/UIKit.h>
#import "RSSRTopicItemProtocol.h"
#import "RSSRTopicCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSRTopicTableViewCell : UITableViewCell

- (void)configureWithItem:(id<RSSRTopicItemProtocol>)topic
                 delegate:(id<RSSRTopicCellDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
