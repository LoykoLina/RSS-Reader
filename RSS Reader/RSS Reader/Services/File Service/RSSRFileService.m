//
//  RSSRFileManager.m
//  RSS Reader
//
//  Created by Lina Loyko on 1/12/21.
//

#import "RSSRFileService.h"


#define BLOCK_EXEC(block, ...)  if (block) { block(__VA_ARGS__); };

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
        BLOCK_EXEC(completion, error);
        return;
    }
    
    [jsonData writeToFile:self.storageFilePath atomically:YES];
    BLOCK_EXEC(completion, nil);
}

- (BOOL)deleteChannel {
    return [[NSFileManager defaultManager] removeItemAtPath:self.storageFilePath error:nil];
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
            BLOCK_EXEC(completion, nil, error);
            return;
        }
        
        RSSRChannel *channel = [RSSRChannel new];
        [channel configureWithDictionary:jsonObject];
        BLOCK_EXEC(completion, [channel autorelease], nil);
        
    } else {
        BLOCK_EXEC(completion, nil, nil);
    }
}


@end
