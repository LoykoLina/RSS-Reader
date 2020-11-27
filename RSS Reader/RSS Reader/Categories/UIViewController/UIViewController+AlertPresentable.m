//
//  UIViewController+AlertPresentable.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/27/20.
//

#import "UIViewController+AlertPresentable.h"

@implementation UIViewController (AlertPresentable)

- (void)showAlertWithTitle:(nonnull NSString *)title message:(nonnull NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
