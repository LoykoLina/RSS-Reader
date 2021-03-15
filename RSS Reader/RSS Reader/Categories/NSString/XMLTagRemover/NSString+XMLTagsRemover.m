//
//  NSString+XMLTagsRemover.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/4/20.
//

#import "NSString+XMLTagsRemover.h"

static NSString * const kTagClose = @">";
static NSString * const kTagOpen = @"<";

@implementation NSString (XMLTagsRemover)

- (NSString *)extractKeyPart {
    if ([self containsString:kTagOpen] && [self containsString:kTagClose]) {
        self = [self substringFromIndex:1];
        self = [self substringToIndex:self.length - 2];
        
        NSRange startRange = [self rangeOfString:kTagClose];
        NSRange endRange = [self rangeOfString:kTagOpen];
        
        NSMutableString *result = [NSMutableString string];
        
        while (startRange.location < endRange.location) {
            self = [self substringFromIndex:startRange.location + startRange.length];
            
            endRange = [self rangeOfString:kTagOpen];
            [result appendString:[self substringToIndex:endRange.location]];
            
            self = [self substringFromIndex:endRange.location + endRange.length];
            
            startRange = [self rangeOfString:kTagClose];
            endRange = [self rangeOfString:kTagOpen];
        }
        
        if (![result isEqualToString:@""]) {
            return result;
        }
    }
    
    return self;
}

@end
