//
//  NSError+UserFriendlyError.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/7/20.
//

#import "NSError+ErrorParsing.h"
#import "ErrorConstants.h"
#import "NSString+LocalizedString.h"

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
        default:
            completion([kDefaultErrorTitle localize], [kDefaultErrorMessage localize]);
            break; 
    }
}

@end
