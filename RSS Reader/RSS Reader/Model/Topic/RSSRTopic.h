//
//  RSSRTopic.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <Foundation/Foundation.h>
#import "RSSRTopicItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const kRSSElementKeyTitle = @"title";
static NSString * const kRSSElementKeyLink = @"link";
static NSString * const kRSSElementKeyPubDate = @"pubDate";
static NSString * const kRSSElementKeyDescription = @"description";
static NSString * const kRSSElementKeyEnclosure = @"enclosure";
static NSString * const kRSSElementKeyItem = @"item";
static NSString * const kRSSElementKeyURL = @"url";

@interface RSSRTopic : NSObject <RSSRTopicItemProtocol>

- (void)configureWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
