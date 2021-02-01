//
//  RSSRTopicItemProtocol.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/25/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSSRTopicItemProtocol <NSObject>

@property (nonatomic, assign) BOOL showDetails;

- (NSString *)itemTitle;
- (NSString *)itemSummary;
- (NSDate *)itemPubDate;
- (NSString *)itemLink;

- (BOOL)isShowDetails;
- (void)setShowDetails:(BOOL)showDetails;

@end

NS_ASSUME_NONNULL_END
