//
//  RSSRTopic.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopic.h"
#import "NSDate+StringConversion.h"

static NSString * const kDefaultDateFormat = @"EE, d LLLL yyyy HH:mm:ss Z";

@interface RSSRTopic ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, retain) NSDate *pubDate;
@property (nonatomic, copy) NSString *imageURL;

@end

@implementation RSSRTopic

- (void)configureWithDictionary:(NSDictionary *)dictionary {
    if (dictionary && dictionary.count > 0) {
        self.title = dictionary[kRSSElementKeyTitle];
        self.link = dictionary[kRSSElementKeyLink];
        self.summary = [self refactorSummary:dictionary[kRSSElementKeyDescription]];
        self.pubDate = [NSDate dateFromString:dictionary[kRSSElementKeyPubDate]
                                   withFormat:kDefaultDateFormat];
        self.imageURL = dictionary[kRSSElementKeyEnclosure];
    } else {
        [NSException raise:NSInvalidArgumentException format:@"Dictionary argument must not be nil or empty!"];
    }
}

- (NSString *)refactorSummary:(NSString*)summary {
    if ([summary hasPrefix:@"<img "]) {
        NSString *newSummary;

        NSRange range = [summary rangeOfString:@" />"];
        newSummary = [summary substringFromIndex:range.location + 3];
        
        range = [newSummary rangeOfString:@"<br"];
        newSummary = [newSummary substringToIndex:range.location];

        return newSummary;
    }
    return summary;
}

- (void)dealloc {
    [_title release];
    [_link release];
    [_summary release];
    [_pubDate release];
    [_imageURL release];
    [super dealloc];
}

#pragma mark - RSSRTopicItemProtocol

- (NSString *)itemLink {
    return self.link;
}

- (NSDate *)itemPubDate {
    return self.pubDate;
}

- (NSString *)itemSummary {
    return self.summary;
}

- (NSString *)itemTitle {
    return self.title;
}

@end
