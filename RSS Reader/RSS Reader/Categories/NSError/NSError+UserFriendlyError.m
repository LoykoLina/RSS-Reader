//
//  NSError+UserFriendlyError.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/7/20.
//

#import "NSError+UserFriendlyError.h"


static NSString * const kParserErrorTitle = @"Parse error";
static NSString * const kParserErrorMessage = @"There was a problem while parsing news feed";

static NSString * const kBadInternetConnectionErrorTitle = @"Bad internet connection";
static NSString * const kBadInternetConnectionErrorMessage = @"Check out your internet connectivity and try to reload";

static NSString * const kDefaultErrorTitle = @"Error";
static NSString * const kDefaultErrorMessage = @"Something went wrong";


@implementation NSError (UserFriendlyError)

- (void)userFriendlyErrorWithCompletion:(void (^)(NSString *title, NSString *message)) completion {
    switch (self.code) {
        case NSXMLParserInternalError:
            completion(kParserErrorTitle, kParserErrorMessage);
            break;
        case NSFileReadUnknownError:
            completion(kBadInternetConnectionErrorTitle, kBadInternetConnectionErrorMessage);
            break;
        default:
            completion(kDefaultErrorTitle, kDefaultErrorMessage);
            break;
    }
}

@end
