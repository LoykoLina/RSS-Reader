//
//  RSSRAnnotationButton.h
//  RSS Reader
//
//  Created by Lina Loyko on 2/22/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSSRAnnotationButton : UIButton

- (instancetype)initWithActionBlock:(void (^)(void))actionBlock;

@end

NS_ASSUME_NONNULL_END
