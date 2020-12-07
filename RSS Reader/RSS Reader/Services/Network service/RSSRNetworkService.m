//
//  RSSRNetworkService.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRNetworkService.h"


@interface RSSRNetworkService ()

@property (nonatomic, retain) NSURLSession *session;

@end

@implementation RSSRNetworkService

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [[NSURLSession sessionWithConfiguration:configuration] retain];
    }
    return _session;
}

- (void)loadDataFromURL:(NSURL *)url
               completion:(void (^)(NSData *data, NSError *error))completion {
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            completion(data, nil);
        }
    }];
    [dataTask resume];
}

- (void)dealloc {
    [_session release];
    [super dealloc];
}

@end
