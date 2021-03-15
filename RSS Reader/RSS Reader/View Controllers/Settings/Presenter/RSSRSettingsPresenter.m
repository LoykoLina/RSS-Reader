//
//  RSSRSettingPresenter.m
//  RSS Reader
//
//  Created by Lina Loyko on 1/8/21.
//

#import "RSSRSettingsPresenter.h"
#import "UIViewController+ViewControllerPresentable.h"
#import "NSError+ErrorParsing.h"

@interface RSSRSettingsPresenter ()

@property (nonatomic, assign) id<RSSFeedsSettingsView, ViewControllerPresentable> feedsSettingsView;
@property (nonatomic) RSSRNetworkService *networkService;
@property (nonatomic) RSSRFeedService *feedService;
@property (nonatomic) RSSRFileService *fileService;

@end

@implementation RSSRSettingsPresenter


#pragma mark -  Initialization 

- (instancetype)initWithFeedService:(RSSRFeedService *)feedService
                     networkService:(RSSRNetworkService *)networkService
                        fileService:(RSSRFileService *)fileService {
    self = [super init];
    if (self) {
        _networkService = networkService;
        _feedService = feedService;
        _fileService = fileService;
    }
    return self;
}


#pragma mark - Error handling

- (void)showError:(NSError *)error {
    [error parseErrorWithCompletion:^(NSString *title, NSString *message) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.feedsSettingsView hideActivitiIndicator];
            [self.feedsSettingsView showAlertWithTitle:title message:message];
        });
    }];
}


#pragma mark - Retrieve feeds from URL

- (void)retrieveFeedsFromHTMLContent:(NSData *)data URL:(NSString *)url {
    __block typeof(self) weakSelf = self;
    [self.feedService retrieveFeedsFromHTMLContent:data
                                         originURL:url
                                        completion:^(NSArray<RSSRChannel *> *channels) {
        if (channels.count > 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.feedsSettingsView hideActivitiIndicator];
                [self.feedsSettingsView displayFeedsOptions:channels];
            });
        } else if (channels) {
            [weakSelf saveChannel:channels[0]];
        } else {
            [self showError:[NSError errorWithType:RSSRNoResultErrorType]];
        }
    }];
}


#pragma mark - RSSFeedsSettingsPresenter

- (void)attachView:(id<RSSFeedsSettingsView, ViewControllerPresentable>)view {
    self.feedsSettingsView = view;
}

- (void)retrieveFeedsFromURL:(NSString *)url {
    __block typeof(self) weakSelf = self;
    [self.networkService loadDataFromURL:[NSURL URLWithString:url]
                              completion:^(NSData *data, NSError *error) {
        if (error) {
            [weakSelf showError:error];
            return;
        }
        
        if ([weakSelf.feedService isRSSFeed:data]) {
            [weakSelf saveChannel:[self.feedService retrieveChannelFromRSSContent:data
                                                                       channelURL:url]];
        } else {
            [weakSelf retrieveFeedsFromHTMLContent:data URL:url];
        }
    }];
}

- (void)saveChannel:(RSSRChannel *)channel {
    __block typeof(self) weakSelf = self;
    [self.fileService saveChannel:channel completion:^(NSError *error) {
        if (error) {
            [weakSelf showError:error];
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.feedsSettingsView hideActivitiIndicator];
            [weakSelf.feedsSettingsView displayAddedFeed:channel];
        });
    }];
}

- (void)deleteChannel {
    if ([self.fileService deleteChannel]) {
        [self.feedsSettingsView hideAddedFeed];
    } else {
        [self showError:[NSError errorWithType:RSSRDeleteChannelErrorType]];
    }
}

@end
