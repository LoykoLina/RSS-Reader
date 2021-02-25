//
//  RSSRChannel.h
//  RSS Reader
//
//  Created by Lina Loyko on 12/24/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kElementKeyTitle = @"title";
static NSString * const kElementKeyLink = @"atom:link";
static NSString * const kElementKeyChannel = @"channel";

@interface RSSRChannel : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *link;

- (instancetype)initWithTitle:(NSString *)title link:(NSString *)link;

- (void)linkRelativeToURL:(NSString *)url;

- (void)configureWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)convertToDictionary;

@end

NS_ASSUME_NONNULL_END
