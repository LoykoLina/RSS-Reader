//
//  NSError+UserFriendlyError.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/7/20.
//

#import "NSError+UserFriendlyError.h"


static NSString * const kParserErrorTitle = @"Parse error";
static NSString * const kParserErrorMessage = @"There was a problem while parsing news feed";

static NSString * const kNoInternetConnectionErrorTitle = @"No internet connection";
static NSString * const kNoInternetConnectionErrorMessage = @"Turn on cellular data or use Wi-Fi to access data";

static NSString * const kNetworkConnectionLostErrorTitle = @"Error";
static NSString * const kNetworkConnectionLostErrorMessage = @"Network connection was lost";

static NSString * const kTimedOutErrorTitle = @"The request timed out";
static NSString * const kTimedOutErrorMessage = @"";

static NSString * const kDefaultErrorTitle = @"Error";
static NSString * const kDefaultErrorMessage = @"Something went wrong";


@implementation NSError (UserFriendlyError)

- (void)userFriendlyError:(void (^)(NSString *title, NSString *message)) completion {
    switch (self.code) {
        case NSXMLParserInternalError:
            completion(kParserErrorTitle, kParserErrorMessage);
            break;
        case NSURLErrorNotConnectedToInternet:
            completion(kNoInternetConnectionErrorTitle, kNoInternetConnectionErrorMessage);
            break;
        case NSURLErrorNetworkConnectionLost:
            completion(kNetworkConnectionLostErrorTitle, kNetworkConnectionLostErrorMessage);
            break;
        case NSURLErrorTimedOut:
            completion(kTimedOutErrorTitle, kTimedOutErrorMessage);
            break;
        default:
            completion(kDefaultErrorTitle, kDefaultErrorMessage);
            break;
    }
}

@end
