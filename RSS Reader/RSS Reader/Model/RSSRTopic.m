//
//  RSSRTopic.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopic.h"
#import "NSDate+StringConversion.h"

static NSString * const kDefaultDateFormat = @"EE, d LLLL yyyy HH:mm:ss Z";

@implementation RSSRTopic

- (void)configureWithDictionary:(NSDictionary *)dictionary {
    if (dictionary && dictionary.count > 0) {
        self.title = dictionary[kRSSElementKeyTitle];
        self.link = dictionary[kRSSElementKeyLink];
        self.topicDescription = [self refactorDescription:dictionary[kRSSElementKeyDescription]];
        self.pubDate = [NSDate dateFromString:dictionary[kRSSElementKeyPubDate]
                                   withFormat:kDefaultDateFormat];
        self.imageURL = dictionary[kRSSElementKeyEnclosure];
    } else {
        [NSException raise:NSInvalidArgumentException format:@"Dictionary argument must not be nil or empty!"];
    }
}

- (NSString *)refactorDescription:(NSString*)description {
    if ([description hasPrefix:@"<img "]) {
        NSString *newDescription;

        NSRange range = [description rangeOfString:@" />"];
        newDescription = [description substringFromIndex:range.location + 3];
        
        range = [newDescription rangeOfString:@"<br"];
        newDescription = [newDescription substringToIndex:range.location];

        return newDescription;
    }
    return description;
}

- (void)dealloc {
    [_title release];
    [_link release];
    [_topicDescription release];
    [_pubDate release];
    [_imageURL release];
    [super dealloc];
}

@end
