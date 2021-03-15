//
//  SceneDelegate.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "SceneDelegate.h"
#import "RSSRTopicsListViewController.h"
#import "RSSRNetworkService.h"
#import "RSSRFeedParser.h"
#import "RSSRTopicsListPresenter.h"
#import "UIColor+RSSRColor.h"
#import "RSSRFileService.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)){
    UIWindow *window = [[[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene] autorelease];
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

- (void)dealloc {
    [_window release];
    [super dealloc];
}

@end
