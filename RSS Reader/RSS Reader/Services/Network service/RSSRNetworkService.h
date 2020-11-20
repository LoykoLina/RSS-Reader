//
//  RSSRNetworkService.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopic;
@class RSSRXMLParser;

@interface RSSRNetworkService : NSObject

- (instancetype)initWithParser:(RSSRXMLParser *)parser;
- (void)loadTopicsFromURL:(NSURL *)url
               completion:(void (^)(NSMutableArray<RSSRTopic *> *topics, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
