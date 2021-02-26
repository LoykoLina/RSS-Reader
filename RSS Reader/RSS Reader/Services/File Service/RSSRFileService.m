//
//  RSSRFileManager.m
//  RSS Reader
//
//  Created by Lina Loyko on 1/12/21.
//

#import "RSSRFileService.h"

static NSString * const kStorageFileName = @"RSSChannelStorage";

@interface RSSRFileService ()

@property (nonatomic, retain) NSString *storageFilePath;

@end

@implementation RSSRFileService

- (NSString *)storageFilePath {
    if (!_storageFilePath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _storageFilePath = [[[paths objectAtIndex: 0] stringByAppendingPathComponent: kStorageFileName] retain];
    }
    return _storageFilePath;
}

- (void)dealloc {
    [_storageFilePath release];
    [super dealloc];
}

- (void)saveChannel:(RSSRChannel *)channel completion:(void (^)(NSError *error))completion {
    NSError *error = nil;
    NSDictionary *jsonObject = [channel convertToDictionary];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                       options:kNilOptions
                                                         error:&error];
    if (error) {
        completion(error);
    }
    
    [jsonData writeToFile:self.storageFilePath atomically:YES];
    completion(nil);
}

- (void)deleteChannel:(void(^)(NSError *error))completion {
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:self.storageFilePath error:&error];
    completion(error);
}

- (void)loadChannel:(void (^)(RSSRChannel *channel, NSError *error))completion {
    NSLog(@"%@", self.storageFilePath);
    NSData *jsonData = [NSData dataWithContentsOfFile:self.storageFilePath];
    
    if (jsonData.length != 0) {
        NSError *error = nil;
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:kNilOptions
                                                                     error:&error];
        if (error) {
            completion(nil, error);
        } else {
            RSSRChannel *channel = [RSSRChannel new];
            [channel configureWithDictionary:jsonObject];
            completion([channel autorelease], nil);
        }
    }
}


@end
