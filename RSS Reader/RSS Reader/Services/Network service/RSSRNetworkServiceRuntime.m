//
//  RSSRNetworkService.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRNetworkServiceRuntime.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "RSSRNetworkService.h"

char *const kSessionIvarName = "_session";
NSString *const kNetworkServiceClassName = @"RSSRNetworkServiceRuntime";

typedef void(^completionBlock)(NSData *data, NSError *error);


NSURLSession *session(id self) {
    Ivar sessionIvar = class_getInstanceVariable([self class], kSessionIvarName);
    NSURLSession *session = object_getIvar(self, sessionIvar);
    
    if (!session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration performSelector:@selector(defaultSessionConfiguration)];
        object_setIvarWithStrongDefault(self, sessionIvar, [NSURLSession performSelector:@selector(sessionWithConfiguration:)
                                                                              withObject:configuration]);
        session = object_getIvar(self, sessionIvar);
    }
    
    return session;
}

void loadData(id self, SEL _cmd, NSURL *url, completionBlock completion) {
    NSURLSessionDataTask *dataTask = [session(self) performSelector:@selector(dataTaskWithURL:completionHandler:)
                                                              withObject:url
                                                              withObject:^(NSData *data, NSURLResponse *response, NSError *error) {
        completion(data, error);
    }];
    
    [dataTask performSelector:@selector(resume)];
}


Class createRSSRNetworkServiceClass() {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        Class NetworkService = objc_allocateClassPair([NSObject class], [kNetworkServiceClassName UTF8String], 0);
        
        class_addProtocol(NetworkService, @protocol(RSSRNetworkService));
        
        class_addIvar(NetworkService, kSessionIvarName, sizeof(NSURLSession *), log2(sizeof(NSURLSession *)), @encode(NSURLSession *));
        
        SEL loadDataSelector = sel_registerName("loadDataFromURL:completion:");
        class_addMethod(NetworkService, loadDataSelector, (IMP)loadData, "v@:@@");
        
        objc_registerClassPair(NetworkService);
    });
    return NSClassFromString(kNetworkServiceClassName);
}

