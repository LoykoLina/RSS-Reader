//
//  AppDelegate.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 13.0, *)) {
        
    } else {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window = window;
        
        ViewController *rootVC = [ViewController new];

        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
        
        [self.window setRootViewController:navigationController];
        self.window.backgroundColor = UIColor.whiteColor;
        [self.window makeKeyAndVisible];
        
        [navigationController release];
        [rootVC release];
        [window release];
    }
    return YES;
}



#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role] autorelease];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
