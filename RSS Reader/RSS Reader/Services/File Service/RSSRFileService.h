//
//  RSSRFileManager.h
//  RSS Reader
//
//  Created by Lina Loyko on 1/12/21.
//

#import <Foundation/Foundation.h>
#import "RSSRChannel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSRFileService : NSObject

- (void)saveChannel:(RSSRChannel *)channel completion:(void (^)(NSError * _Nullable error))completion;
- (void)deleteChannel:(void(^)(NSError * _Nullable error))completion;
- (void)loadChannel:(void(^)(RSSRChannel * _Nullable channel, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
