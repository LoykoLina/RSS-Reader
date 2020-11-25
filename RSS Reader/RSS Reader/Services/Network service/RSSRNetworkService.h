//
//  RSSRNetworkService.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSRNetworkService : NSObject

- (void)loadDataFromURL:(NSURL *)url
               completion:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
