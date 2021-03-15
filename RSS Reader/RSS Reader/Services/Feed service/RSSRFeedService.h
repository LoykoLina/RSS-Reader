//
//  RSSRFeedService.h
//  RSS Reader
//
//  Created by Lina Loyko on 1/8/21.
//

#import <Foundation/Foundation.h>
#import "RSSRChannel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSRFeedService : NSObject

- (void)retrieveFeedsFromHTMLContent:(NSData *)data
                           originURL:(NSString *)url
                          completion:(void (^)(NSArray<RSSRChannel *> * _Nullable channels))completion;

- (BOOL)isRSSFeed:(NSData *)data;

- (RSSRChannel *)retrieveChannelFromRSSContent:(NSData *)data
                                    channelURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
