//
//  main.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    }
}
