//
//  RSSRSettingPresenter.h
//  RSS Reader
//
//  Created by Lina Loyko on 1/8/21.
//

#import <Foundation/Foundation.h>
#import "RSSFeedsSettingsPresenter.h"
#import "RSSRFeedService.h"
#import "RSSRNetworkService.h"
#import "RSSRFileService.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSRSettingsPresenter : NSObject <RSSFeedsSettingsPresenter>

- (instancetype)initWithFeedService:(RSSRFeedService *)feedService
                     networkService:(RSSRNetworkService *)networkService
                        fileService:(RSSRFileService *)fileService;

@end

NS_ASSUME_NONNULL_END
