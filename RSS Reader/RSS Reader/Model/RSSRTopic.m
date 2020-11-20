//
//  RSSRTopic.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopic.h"

@implementation RSSRTopic

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = [dictionary[kRSSElementKeyTitle] copy];
        _link = [dictionary[kRSSElementKeyLink] copy];
        _topicDescription = [[self refactorDescription:dictionary[kRSSElementKeyDescription]] copy];
        _pubDate = [self dateFromString:dictionary[kRSSElementKeyPubDate]];
        _imageURL = [dictionary[kRSSElementKeyEnclosure] copy];
    }
    return self;
}

- (void)dealloc {
    [_title release];
    [_link release];
    [_topicDescription release];
    [_pubDate release];
    [_imageURL release];
    [super dealloc];
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

- (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter new] autorelease];
    [dateFormatter setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
    return [dateFormatter dateFromString:dateString];
}

- (NSString *)formattedDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter new] autorelease];
    [dateFormatter setDateFormat:@"MMM d, yyyy HH:mm"];
    return [dateFormatter stringFromDate:self.pubDate];
}

@end
