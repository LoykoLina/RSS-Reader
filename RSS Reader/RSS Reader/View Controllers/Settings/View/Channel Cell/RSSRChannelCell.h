//
//  RSSRChannelCell.h
//  RSS Reader
//
//  Created by Lina Loyko on 1/13/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSRChannelCell : UITableViewCell

- (void)configureWithTitle:(NSString *)title deleteHandler:(void(^)(void))handler ;

@end

NS_ASSUME_NONNULL_END
