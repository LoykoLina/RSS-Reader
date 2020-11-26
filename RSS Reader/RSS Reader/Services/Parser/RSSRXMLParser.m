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
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.items = [NSMutableArray array];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    if ([elementName isEqualToString:kRSSElementKeyItem]) {
        self.itemDictionary = [NSMutableDictionary dictionary];

    } else if ([elementName isEqualToString:kRSSElementKeyTitle] ||
               [elementName isEqualToString:kRSSElementKeyLink] ||
               [elementName isEqualToString:kRSSElementKeyPubDate] ||
               [elementName isEqualToString:kRSSElementKeyDescription]) {
        self.parsingDictionary = [NSMutableDictionary dictionary];
        self.parsingString = [NSMutableString string];

    } else if ([elementName isEqualToString:kRSSElementKeyEnclosure]) {
        self.parsingDictionary = [NSMutableDictionary dictionary];
        NSMutableString *enclosureURL = [attributeDict[kRSSElementKeyURL] mutableCopy];
        self.parsingString = enclosureURL;
        [enclosureURL release];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.parsingString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (self.parsingString) {
        [self.parsingDictionary setObject:self.parsingString forKey:elementName];
        self.parsingString = nil;
    }
    
    if ([elementName isEqualToString:kRSSElementKeyTitle] ||
        [elementName isEqualToString:kRSSElementKeyLink] ||
        [elementName isEqualToString:kRSSElementKeyPubDate] ||
        [elementName isEqualToString:kRSSElementKeyDescription] ||
        [elementName isEqualToString:kRSSElementKeyEnclosure]) {
        [self.itemDictionary addEntriesFromDictionary:self.parsingDictionary];

    } else if ([elementName isEqualToString:kRSSElementKeyItem]) {
        RSSRTopic *item = [RSSRTopic new];
        [item configureWithDictionary:self.itemDictionary];
        [self.items addObject:item];
        [item release];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (self.completion) {
        self.completion(self.items, nil);
    }
}



@end