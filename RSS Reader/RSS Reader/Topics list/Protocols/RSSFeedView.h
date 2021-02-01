//
//  RSSFeedView.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/18/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSSFeedView <NSObject>

- (void)reloadData;
- (void)endRefreshing;
- (void)stopActivityIndicator;

@end

NS_ASSUME_NONNULL_END
