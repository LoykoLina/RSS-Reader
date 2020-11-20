//
//  RSSRXMLParser.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopic;

@interface RSSRXMLParser : NSObject

- (void)parseTopics:(NSData *)data
         completion:(void (^)(NSMutableArray<RSSRTopic *> *topics, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
