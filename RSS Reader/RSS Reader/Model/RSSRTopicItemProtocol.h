//
//  RSSRTopicItemProtocol.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/25/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSSRTopicItemProtocol <NSObject>

- (NSString *)itemTitle;
- (NSString *)itemSummary;
- (NSDate *)itemPubDate;
- (NSString *)itemLink;

@end

NS_ASSUME_NONNULL_END
