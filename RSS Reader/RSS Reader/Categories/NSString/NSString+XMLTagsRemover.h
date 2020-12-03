//
//  NSString+XMLTagsRemover.h
//  RSS Reader
//
//  Created by Lina Loyko on 12/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XMLTagsRemover)

- (NSString *)extractKeyPart;

@end

NS_ASSUME_NONNULL_END
