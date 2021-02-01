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

NS_ASSUME_NONNULL_BEGIN

@class RSSRXMLParser;
@class RSSRNetworkService;
@class RSSRTopic;

@interface RSSRTopicsListPresenter : NSObject <RSSFeedPresenter>

- (instancetype)initWithService:(RSSRNetworkService *)service
                         parser:(RSSRXMLParser *)parser;

@end

NS_ASSUME_NONNULL_END
