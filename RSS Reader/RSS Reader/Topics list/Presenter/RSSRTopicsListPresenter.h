//
//  RSSRTopicsListPresenter.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/18/20.
//

#import <Foundation/Foundation.h>
#import "RSSRTopicsListView.h"

NS_ASSUME_NONNULL_BEGIN

@class RSSRXMLParser;
@class RSSRNetworkService;

@interface RSSRTopicsListPresenter : NSObject

@property (nonatomic, assign) id<RSSRTopicsListView> topicsListView;

- (instancetype)initWithService:(RSSRNetworkService *)service
                         parser:(RSSRXMLParser *)parser;
- (void)loadTopics;

@end

NS_ASSUME_NONNULL_END
