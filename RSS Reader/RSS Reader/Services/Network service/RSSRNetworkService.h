//
//  RSSRNetworkService.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSRNetworkService : NSObject

- (void)loadTopicsFromURL:(NSURL *)url
               completion:(void (^)(NSData *data, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
