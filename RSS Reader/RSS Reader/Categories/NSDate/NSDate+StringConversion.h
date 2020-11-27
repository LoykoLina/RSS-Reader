//
//  NSDate+StringConversion.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/24/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (StringConversion)

- (NSString *)stringWithFormat:(NSString *)format;
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
