//
//  RSSRNetworkService.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRNetworkService.h"

static NSString * const kNilCompletionMessage = @"Completion must not be nil!";

@interface RSSRNetworkService ()

@property (nonatomic) NSURLSession *session;

@end

@implementation RSSRNetworkService

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}


- (void)loadDataFromURL:(NSURL *)url
             completion:(void (^)(NSData *data, NSError *error))completion {
    NSAssert(completion, kNilCompletionMessage);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url.absoluteURL];

    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completion(data, error);
    }];

    [dataTask resume];
}

@end
