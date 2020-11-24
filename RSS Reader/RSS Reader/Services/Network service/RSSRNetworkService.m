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
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

- (void)loadTopicsFromURL:(NSURL *)url
               completion:(void (^)(NSData *data, NSError *error))completion {
    NSURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            completion(data, nil);
        }
    }];
    [dataTask resume];
    
    [request release];
}

- (void)dealloc {
    [_session release];
    [super dealloc];
}

@end
