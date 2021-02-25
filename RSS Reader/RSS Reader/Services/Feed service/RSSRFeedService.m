//
//  RSSRFeedService.m
//  RSS Reader
//
//  Created by Lina Loyko on 1/8/21.
//

#import "RSSRFeedService.h"

static NSString * const kRSSTypeAndTitleMark = @"type=\"application/rss+xml\" title=\"";
static NSString * const kEndQuotationMark = @">";
static NSString * const kDoubleQuotes = @"\"";
static NSString * const kRSSFeedMark = @"<rss version=";

static NSString * const kTitleOpenTag = @"<title>";
static NSString * const kTitleCloseTag = @"</title>";

static NSString * const kSlash = @"/";


@interface RSSRFeedService ()

@property (nonatomic, retain) NSMutableArray *channels;

@end

@implementation RSSRFeedService


#pragma mark - Deallocation

- (void)dealloc {
    [_channels release];
    [super dealloc];
}


#pragma mark - Retrieve feeds from HTML content

- (void)retrieveFeedsFromHTMLContent:(NSData *)data
                           originURL:(NSString *)url
                         completion:(void (^)(NSArray<RSSRChannel *> *channels))completion {
    NSString *htmlString = [NSString stringWithUTF8String:data.bytes];
    [self findChannelsFromHTMLString:htmlString];
    
    for (RSSRChannel *channel in self.channels) {
        if ([channel.link hasPrefix:kSlash]) {
            [channel linkRelativeToURL:url];
        }
    }
    
    completion(self.channels);
}

- (void)findChannelsFromHTMLString:(NSString *)htmlString {
    if (![htmlString containsString:kRSSTypeAndTitleMark]) {
        return;
    }
    
    htmlString = [htmlString substringFromIndex:[htmlString rangeOfString:kRSSTypeAndTitleMark].location + kRSSTypeAndTitleMark.length];
    
    if (!self.channels) {
        self.channels = [NSMutableArray new];
    }
    [self.channels addObject:[self extractChannelfromHTMLString:htmlString]];
    htmlString = [htmlString substringFromIndex:[htmlString rangeOfString:kEndQuotationMark].location + kEndQuotationMark.length];
    
    [self findChannelsFromHTMLString:htmlString];
    
}

- (RSSRChannel *)extractChannelfromHTMLString:(NSString *)htmlString {
    NSRange range = [htmlString rangeOfString:kDoubleQuotes];
    NSString *title = [htmlString substringToIndex:range.location];
    htmlString = [htmlString substringFromIndex:range.location + range.length];
    
    htmlString = [htmlString substringFromIndex:[htmlString rangeOfString:kDoubleQuotes].location + kDoubleQuotes.length];
    NSString *link = [htmlString substringToIndex:[htmlString rangeOfString:kDoubleQuotes].location];
    
    RSSRChannel *channel = [[RSSRChannel alloc] initWithTitle:title link:link];
    
    return [channel autorelease];
}


#pragma mark - Checking for RSS Feed

- (BOOL)isRSSFeed:(NSData *)data {
    NSString *contentString = [NSString stringWithUTF8String:data.bytes];
    return [contentString containsString:kRSSFeedMark] ? YES : NO;
}


#pragma mark - Retrieve channel From RSS feed content

- (RSSRChannel *)retrieveChannelFromRSSContent:(NSData *)data channelURL:(NSString *)url {
    NSString *content = [NSString stringWithUTF8String:data.bytes];
    NSRange range = [content rangeOfString:kTitleOpenTag];
    content = [content substringFromIndex:range.location + range.length];
    range = [content rangeOfString:kTitleCloseTag];
    content = [content substringToIndex:range.location];
    
    RSSRChannel *channel = [[RSSRChannel alloc] initWithTitle:content link:url];
    return [channel autorelease];
}


@end
