//
//  RSSRNetworkService.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRNetworkService.h"

@interface RSSRNetworkService ()

@property (nonatomic, retain) NSURLSession *session;
@property (atomic, copy) void (^completion)(NSData *data, NSError *error);

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
    self.completion = completion;
    [NSThread detachNewThreadSelector:@selector(loadDataFromURL:) toTarget:self withObject:url];
}

- (void)loadDataFromURL:(NSURL *)url {
    @autoreleasepool {
        __block typeof(self) weakSelf = self;
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                weakSelf.completion(nil, error);
            } else {
                weakSelf.completion(data, nil);
            }
        }];
        [dataTask resume];
    }
}

- (void)dealloc {
    [_session release];
    [_completion release];
    [super dealloc];
}

@end
