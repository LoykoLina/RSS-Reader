//
//  NSString+LocalizedProperty.m
//  RSS Reader
//
//  Created by Lina Loyko on 1/20/21.
//

#import "NSString+LocalizedString.h"

@implementation NSString (LocalizedString)

- (NSString *)localize {
    return NSLocalizedString(self, "");
}

@end
