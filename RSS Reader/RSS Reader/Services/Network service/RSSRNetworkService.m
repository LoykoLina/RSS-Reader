//
//  RSSRNetworkService.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRNetworkService.h"
#import "RSSRTopic.h"
#import "RSSRXMLParser.h"

@interface RSSRNetworkService ()

@property (nonatomic, retain) NSURLSession *session;
@property (nonatomic, retain) RSSRXMLParser *parser;

@end

@implementation RSSRNetworkService

- (instancetype)initWithParser:(RSSRXMLParser *)parser {
    self = [super init];
    if (self) {
        _parser = [parser retain];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}

- (void)loadTopicsFromURL:(NSURL *)url
               completion:(void (^)(NSMutableArray<RSSRTopic *> *topics, NSError *error))completion {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    __block typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [weakSelf retain];
        if (error) {
            completion(nil, error);
        } else {
            [weakSelf.parser parseTopics:data completion:completion];
        }
        [weakSelf release];
    }];
    [dataTask resume];
    
    [request release];
}

- (void)dealloc {
    [_session release];
    [_parser release];
    [super dealloc];
}

@end
