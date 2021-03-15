//
//  RSSRSettingsController.h
//  RSS Reader
//
//  Created by Lina Loyko on 12/23/20.
//

#import <UIKit/UIKit.h>
#import "RSSFeedsSettingsView.h"
#import "RSSFeedsSettingsPresenter.h"
#import "UIViewController+ViewControllerPresentable.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSRSettingsController : UIViewController <RSSFeedsSettingsView, ViewControllerPresentable>

- (instancetype)initWithPresenter:(id<RSSFeedsSettingsPresenter>)presenter
                          channel:(RSSRChannel *)channel;

@end

NS_ASSUME_NONNULL_END
