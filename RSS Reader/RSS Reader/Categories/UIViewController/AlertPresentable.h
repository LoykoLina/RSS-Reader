//
//  AlertPresentable.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/27/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AlertPresentable <NSObject>

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
