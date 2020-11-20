//
//  RSSRTopic.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kRSSElementKeyTitle = @"title";
static NSString * const kRSSElementKeyLink = @"link";
static NSString * const kRSSElementKeyPubDate = @"pubDate";
static NSString * const kRSSElementKeyDescription = @"description";
static NSString * const kRSSElementKeyEnclosure = @"enclosure";
static NSString * const kRSSElementKeyItem = @"item";
static NSString * const kRSSElementKeyURL = @"url";

@interface RSSRTopic : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *topicDescription;
@property (nonatomic, retain) NSDate *pubDate;
@property (nonatomic, copy) NSString *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)formattedDate;

@end

NS_ASSUME_NONNULL_END
