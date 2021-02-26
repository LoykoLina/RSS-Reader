//
//  AppDelegate.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "AppDelegate.h"
#import "RSSRTopicsListViewController.h"
#import "RSSRNetworkService.h"
#import "RSSRFeedParser.h"
#import "RSSRTopicsListPresenter.h"
#import "UIColor+RSSRColor.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 13.0, *)) {
    } else {
        UIWindow *window = [[[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds] autorelease];
        self.window = window;
        
        RSSRFeedParser *parser = [RSSRFeedParser new];
        RSSRNetworkService *service = [RSSRNetworkService new];
        RSSRFileService *fileService = [RSSRFileService new];
        RSSRTopicsListPresenter *presenter = [[RSSRTopicsListPresenter alloc] initWithService:service
                                                                                       parser:parser
                                                                                  fileService:fileService];
        RSSRTopicsListViewController *rootVC = [[RSSRTopicsListViewController alloc] initWithPresenter:presenter];

        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
        
        [self.window setRootViewController:navigationController];
        self.window.backgroundColor = UIColor.RSSRBackgroundColor;
        [self.window makeKeyAndVisible];
        
        [navigationController release];
        [rootVC release];
        [parser release];
        [presenter release];
        [service release];
        [fileService release];
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
