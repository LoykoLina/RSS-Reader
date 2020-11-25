//
//  RSSRTopicsListTableViewController.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import <UIKit/UIKit.h>
#import "RSSRTopicsListView.h"

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopicsListPresenter;

@interface RSSRTopicsListTableViewController : UITableViewController <RSSRTopicsListView>

- (instancetype)initWithPresenter:(RSSRTopicsListPresenter *)presenter;

@end

NS_ASSUME_NONNULL_END
