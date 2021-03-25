//
//  RSSRNetworkService.h
//  RSS Reader
//
//  Created by Lina Loyko on 3/24/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RSSRNetworkService <NSObject>

- (void)loadDataFromURL:(NSURL *)url
             completion:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
