//
//  RSSRChannel.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/24/20.
//

#import "RSSRChannel.h"

@interface RSSRChannel ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;

@end

@implementation RSSRChannel


#pragma mark - Initialization & Deallocation

- (instancetype)initWithTitle:(NSString *)title link:(NSString *)link {
    self = [super init];
    if (self) {
        _title = title;
        _link = link;
    }
    return self;
}


- (void)linkRelativeToURL:(NSString *)url {
    NSMutableString *newLink = [url mutableCopy];
    [newLink appendString:self.link];
    self.link = newLink;
}


#pragma mark - Dictionary support

- (void)configureWithDictionary:(NSDictionary *)dictionary {
    self.title = dictionary[kElementKeyTitle];
    self.link = dictionary[kElementKeyLink];
}

- (NSDictionary *)convertToDictionary {
    return @{ kElementKeyTitle : self.title,
              kElementKeyLink : self.link };
}


@end
