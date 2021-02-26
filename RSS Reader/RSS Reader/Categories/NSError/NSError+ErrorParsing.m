//
//  NSError+UserFriendlyError.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/7/20.
//

#import "NSError+ErrorParsing.h"
#import "ErrorConstants.h"
#import "NSString+LocalizedString.h"

static NSString * const kErrorDomain = @"linaloyko.com.RSS-Reader";

@implementation NSError (ErrorParsing)

- (void)parseErrorWithCompletion:(void (^)(NSString *title, NSString *message)) completion {
    switch (self.code) {
        case NSXMLParserInternalError:
            completion([kParserErrorTitle localize], [kParserErrorMessage localize]);
            break;
        case NSURLErrorNotConnectedToInternet:
            completion([kNoInternetConnectionErrorTitle localize], [kNoInternetConnectionErrorMessage localize]);
            break;
        case NSPropertyListWriteInvalidError:
            completion([kSaveChannelErrorTitle localize], [kSaveChannelErrorMessage localize]);
            break;
        case NSPropertyListReadCorruptError:
            completion([kLoadChannelErrorTitle localize], [kLoadChannelErrorMessage localize]);
            break;
        case RSSRNoResultErrorType:
            completion([kNoResultErrorTitle localize], [kNoResultErrorMessage localize]);
            break;
        case RSSRDeleteChannelErrorType:
            completion([kDeleteChannelErrorTitle localize], [kDefaultErrorMessage localize]);
            break;
        default:
            completion([kDefaultErrorTitle localize], [kDefaultErrorMessage localize]);
            break; 
    }
}

+ (NSError *)errorWithType:(RSSRErrorType)type {
    NSError *error = nil;
    switch (type) {
        case RSSRNoResultErrorType:
            error = [NSError errorWithDomain:kErrorDomain code:2001 userInfo:@{}];
            break;
        case RSSRDeleteChannelErrorType:
            error = [NSError errorWithDomain:kErrorDomain code:2000 userInfo:@{}];
            break;
    }
    return error;
}

@end
