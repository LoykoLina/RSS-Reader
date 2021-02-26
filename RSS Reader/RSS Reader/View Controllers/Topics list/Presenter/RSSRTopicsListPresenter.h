//
//  RSSRTopicsListPresenter.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/18/20.
//

#import <Foundation/Foundation.h>
#import "RSSFeedView.h"
#import "RSSFeedPresenter.h"
#import "ViewControllerPresentable.h"
#import "RSSRFileService.h"

NS_ASSUME_NONNULL_BEGIN

@class RSSRFeedParser;
@class RSSRNetworkService;
@class RSSRTopic;

@interface RSSRTopicsListPresenter : NSObject <RSSFeedPresenter>

- (instancetype)initWithService:(RSSRNetworkService *)service
                         parser:(RSSRFeedParser *)parser
                    fileService:(RSSRFileService *)fileService;

@end

NS_ASSUME_NONNULL_END
