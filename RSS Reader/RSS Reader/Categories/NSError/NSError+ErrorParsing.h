//
//  NSError+UserFriendlyError.h
//  RSS Reader
//
//  Created by Lina Loyko on 12/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RSSRDeleteChannelErrorType = 2000,
    RSSRNoResultErrorType,
} RSSRErrorType;


@interface NSError (ErrorParsing)

- (void)parseErrorWithCompletion:(void (^)(NSString * _Nonnull title, NSString * _Nonnull message)) completion;

+ (NSError *)errorWithType:(RSSRErrorType)type;

@end

NS_ASSUME_NONNULL_END
