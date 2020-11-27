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
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    self.window = window;
    self.window.backgroundColor = UIColor.whiteColor;
    
    RSSRXMLParser *parser = [RSSRXMLParser new];
    RSSRNetworkService *service = [RSSRNetworkService new];
    RSSRTopicsListPresenter *presenter = [[RSSRTopicsListPresenter alloc] initWithService:service
                                                                                   parser:parser];
    RSSRTopicsListViewController *rootVC = [[RSSRTopicsListViewController alloc] initWithPresenter:presenter];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
    
    [navigationController release];
    [rootVC release];
    [window release];
    [parser release];
    [presenter release];
    [service release];
}

- (void)dealloc {
    [_window release];
    [super dealloc];
}

@end
