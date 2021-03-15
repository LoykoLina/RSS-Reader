//
//  RSSFeedsSettingsPresenter.h
//  RSS Reader
//
//  Created by Lina Loyko on 1/8/21.
//

#import <Foundation/Foundation.h>
#import "RSSFeedsSettingsView.h"
#import "UIViewController+ViewControllerPresentable.h"

NS_ASSUME_NONNULL_BEGIN

@class RSSRChannel;

@protocol RSSFeedsSettingsPresenter <NSObject>

- (void)attachView:(id<RSSFeedsSettingsView, ViewControllerPresentable>)view;
- (void)retrieveFeedsFromURL:(NSString *)url;
- (void)saveChannel:(RSSRChannel *)channel;
- (void)deleteChannel;

@end

NS_ASSUME_NONNULL_END
