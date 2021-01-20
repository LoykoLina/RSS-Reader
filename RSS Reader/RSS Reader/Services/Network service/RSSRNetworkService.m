//
//  RSSRNetworkService.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRNetworkService.h"

@implementation RSSRNetworkService

- (void)loadDataFromURL:(NSURL *)url
             completion:(void (^)(NSData *data, NSError *error))completion {
    [NSThread detachNewThreadWithBlock:^{
        @autoreleasepool {
            NSError *error;
            NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
            completion(data, error);
        }
    }];
}

@end
