//
//  RSSRXMLParser.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRXMLParser.h"
#import "RSSRTopic.h"

@interface RSSRXMLParser () <NSXMLParserDelegate>

@property (nonatomic, retain) NSMutableDictionary *itemDictionary;
@property (nonatomic, retain) NSMutableDictionary *parsingDictionary;
@property (nonatomic, retain) NSMutableString *parsingString;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, copy) void (^completion)(NSMutableArray<RSSRTopic *> *, NSError *);

@end

@implementation RSSRXMLParser

- (void)parseTopics:(NSData *)data
         completion:(void (^)(NSMutableArray<RSSRTopic *> *topics, NSError *error))completion {
    self.completion = completion;
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    [parser release];
    
}

- (void)dealloc {
    [_itemDictionary release];
    [_parsingString release];
    [_parsingDictionary release];
    [_items release];
    [_completion release];
    [super dealloc];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (self.completion) {
        self.completion(nil, parseError);
    }

    [self.items release];
    [self.itemDictionary release];
    [self.parsingDictionary release];
    [self.parsingString release];

    self.items = nil;
    self.itemDictionary = nil;
    self.parsingDictionary = nil;
    self.parsingString = nil;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.items = [NSMutableArray new];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString:kRSSElementKeyItem]) {
        self.itemDictionary = [NSMutableDictionary new];

    } else if ([elementName isEqualToString:kRSSElementKeyTitle] ||
               [elementName isEqualToString:kRSSElementKeyLink] ||
               [elementName isEqualToString:kRSSElementKeyPubDate] ||
               [elementName isEqualToString:kRSSElementKeyDescription]) {
        self.parsingDictionary = [NSMutableDictionary new];
        self.parsingString = [NSMutableString new];

    } else if ([elementName isEqualToString:kRSSElementKeyEnclosure]) {
        self.parsingDictionary = [NSMutableDictionary new];
        self.parsingString = [attributeDict[kRSSElementKeyURL] mutableCopy];

    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.parsingString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (self.parsingString) {
        [self.parsingDictionary setObject:self.parsingString forKey:elementName];
        [self.parsingString release];
        self.parsingString = nil;
    }
    
    if ([elementName isEqualToString:kRSSElementKeyTitle] ||
        [elementName isEqualToString:kRSSElementKeyLink] ||
        [elementName isEqualToString:kRSSElementKeyPubDate] ||
        [elementName isEqualToString:kRSSElementKeyDescription] ||
        [elementName isEqualToString:kRSSElementKeyEnclosure]) {
        [self.itemDictionary addEntriesFromDictionary:self.parsingDictionary];
        [self.parsingDictionary release];
        self.parsingDictionary = nil;

    } else if ([elementName isEqualToString:kRSSElementKeyItem]) {
        RSSRTopic *item = [[RSSRTopic alloc] initWithDictionary:self.itemDictionary];
        [self.itemDictionary release];
        self.itemDictionary = nil;
        [self.items addObject:item];
        [item release];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        self.completion(self.items, nil);
    }

    [self.items release];
    self.items = nil;
    [self.itemDictionary release];
    [self.parsingDictionary release];
    [self.parsingString release];

    self.items = nil;
    self.itemDictionary = nil;
    self.parsingDictionary = nil;
    self.parsingString = nil;
}



@end
