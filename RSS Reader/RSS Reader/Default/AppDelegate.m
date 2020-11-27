//
//  AppDelegate.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "AppDelegate.h"
#import "RSSRTopicsListViewController.h"
#import "RSSRNetworkService.h"
#import "RSSRXMLParser.h"
#import "RSSRTopicsListPresenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 13.0, *)) {
        
    } else {
        UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        self.window = window;
        self.window.backgroundColor = UIColor.whiteColor;
        
        RSSRXMLParser *parser = [RSSRXMLParser new];
        RSSRNetworkService *service = [RSSRNetworkService new];
        RSSRTopicsListPresenter *presenter = [[RSSRTopicsListPresenter alloc] initWithService:service
                                                                                       parser:parser];
        RSSRTopicsListViewController *rootVC = [[RSSRTopicsListViewController alloc] initWithPresenter:presenter];

        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
        
        [self.window setRootViewController:navigationController];
        self.window.backgroundColor = UIColor.whiteColor;
        [self.window makeKeyAndVisible];
        
        [navigationController release];
        [rootVC release];
        [window release];
        [parser release];
        [presenter release];
        [service release];
    }
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
                              options:(UISceneConnectionOptions *)options API_AVAILABLE(ios(13.0)){
    return [[[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role] autorelease];
}

@end
