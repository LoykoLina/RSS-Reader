//
//  NSDate+StringConversion.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/24/20.
//

#import "NSDate+StringConversion.h"

static NSString * const kLocaleIdentifier = @"en_US_POSIX";

@implementation NSDate (StringConversion)

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:kLocaleIdentifier]];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:kLocaleIdentifier]];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

@end
