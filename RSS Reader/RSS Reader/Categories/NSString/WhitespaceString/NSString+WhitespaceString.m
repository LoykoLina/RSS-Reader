//
//  NSString+WhitespaceString.m
//  RSS Reader
//
//  Created by Lina Loyko on 2/17/21.
//

#import "NSString+WhitespaceString.h"

@implementation NSString (WhitespaceString)

- (BOOL)isWhitespaceString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0;
}

@end
