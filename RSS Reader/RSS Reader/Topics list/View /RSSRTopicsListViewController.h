//
//  RSSRTopicsListViewController.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <UIKit/UIKit.h>
#import "RSSFeedView.h"
#import "RSSFeedPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSRTopicsListViewController : UIViewController <RSSFeedView, UITableViewDataSource>

- (instancetype)initWithPresenter:(id<RSSFeedPresenter>)presenter;

@end

NS_ASSUME_NONNULL_END
