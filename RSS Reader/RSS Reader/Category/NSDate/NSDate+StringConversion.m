//
//  NSDate+StringConversion.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/24/20.
//

#import "NSDate+StringConversion.h"

@implementation NSDate (StringConversion)

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

+ (instancetype)dateFromString:(NSString *)dateString withFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

@end
