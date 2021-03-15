//
//  RSSRXMLParser.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopic;

@interface RSSRFeedParser : NSObject

- (void)parseTopics:(NSData *)data
         completion:(void (^)(NSMutableArray<RSSRTopic *> * _Nullable topics, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
