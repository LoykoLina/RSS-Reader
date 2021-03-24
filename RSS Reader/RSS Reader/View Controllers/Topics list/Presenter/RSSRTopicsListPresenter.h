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
#import "RSSRNetworkService.h"
#import "RSSRTopic.h"
#import "RSSRFeedParser.h"

NS_ASSUME_NONNULL_BEGIN

@interface RSSRTopicsListPresenter : NSObject <RSSFeedPresenter>

- (instancetype)initWithService:(id<RSSRNetworkService>)service
                         parser:(RSSRFeedParser *)parser
                    fileService:(RSSRFileService *)fileService;

@end

NS_ASSUME_NONNULL_END
