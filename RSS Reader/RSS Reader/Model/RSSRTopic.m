//
//  RSSRTopic.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopic.h"
#import "NSDate+StringConversion.h"
#import "NSString+XMLTagsRemover.h"

static NSString * const kDefaultDateFormat = @"EE, d LLLL yyyy HH:mm:ss Z";
static NSString * const kNilDictionaryMessage = @"Dictionary argument must not be nil or empty!";

@interface RSSRTopic ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, retain) NSDate *pubDate;
@property (nonatomic, copy) NSString *imageURL;

@end

@implementation RSSRTopic

@synthesize showDetails;

- (void)configureWithDictionary:(NSDictionary *)dictionary {
    if (dictionary && dictionary.count > 0) {
        self.title = dictionary[kRSSElementKeyTitle];
        self.link = dictionary[kRSSElementKeyLink];
        self.summary = [dictionary[kRSSElementKeyDescription] extractKeyPart];
        self.pubDate = [NSDate dateFromString:dictionary[kRSSElementKeyPubDate]
                                   withFormat:kDefaultDateFormat];
        self.imageURL = dictionary[kRSSElementKeyEnclosure];
    } else {
        [NSException raise:NSInvalidArgumentException format:kNilDictionaryMessage];
    }
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

- (BOOL)isShowDetails {
    return self.showDetails;
}


@end
