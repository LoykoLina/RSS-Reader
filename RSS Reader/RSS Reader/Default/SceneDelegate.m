//
//  SceneDelegate.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "SceneDelegate.h"
#import "RSSRTopicsListViewController.h"
#import "RSSRNetworkService.h"
#import "RSSRXMLParser.h"
#import "RSSRTopicsListPresenter.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)){
    UIWindow *window = [[[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene] autorelease];
    self.window = window;
    self.window.backgroundColor = UIColor.whiteColor;
    
    RSSRXMLParser *parser = [[RSSRXMLParser new] autorelease];
    RSSRNetworkService *service = [[RSSRNetworkService new] autorelease];
    RSSRTopicsListPresenter *presenter = [[[RSSRTopicsListPresenter alloc] initWithService:service
                                                                                    parser:parser] autorelease];
    RSSRTopicsListViewController *rootVC = [[[RSSRTopicsListViewController alloc] initWithPresenter:presenter] autorelease];
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:rootVC] autorelease];
    
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
}

- (void)dealloc {
    [_window release];
    [super dealloc];
}

@end
