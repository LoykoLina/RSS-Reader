//
//  UIViewController+AlertPresentable.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/27/20.
//

#import "UIViewController+ViewControllerPresentable.h"

@implementation UIViewController (ViewControllerPresentable)

- (void)showAlertWithTitle:(nonnull NSString *)title message:(nonnull NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)pushViewController:(nonnull UIViewController *)viewController {
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}

@end
