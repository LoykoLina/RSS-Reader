//
//  RSSRTopicTableViewCell.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <UIKit/UIKit.h>
#import "RSSRTopicItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSRTopicTableViewCell : UITableViewCell

- (void)configureWithItem:(id<RSSRTopicItemProtocol>)topic
            reloadHandler:(void(^)(id<RSSRTopicItemProtocol> topic))handler;

@end

NS_ASSUME_NONNULL_END
