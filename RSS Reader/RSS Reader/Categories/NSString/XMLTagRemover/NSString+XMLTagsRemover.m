//
//  NSString+XMLTagsRemover.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/4/20.
//

#import "NSString+XMLTagsRemover.h"

static NSString * const kTagBeforeKeyPart = @"/>";
static NSString * const kTagAfterKeyPart = @"<br";

@implementation NSString (XMLTagsRemover)

- (NSString *)extractKeyPart {
    if ([self containsString:kTagBeforeKeyPart]) {
        NSRange range = [self rangeOfString:kTagBeforeKeyPart];
        NSString *newDescription = [self substringFromIndex:range.location + kTagBeforeKeyPart.length];
        
        range = [newDescription rangeOfString:kTagAfterKeyPart];
        newDescription = [newDescription substringToIndex:range.location];

        return newDescription;
    }
    return self;
}

@end
