//
//  RSSRSettingsController.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/23/20.
//

#import "RSSRSettingsController.h"
#import "RSSFeedsSettingsPresenter.h"
#import "RSSRChannel.h"
#import "RSSRChannelCell.h"
#import "RSSRChannelOptionCell.h"
#import "UIColor+RSSRColor.h"
#import "RSSRSelfResizedTableView.h"
#import "NSString+WhitespaceString.h"

static NSString * const kTitle = @"Settings";
static NSString * const kNoFeedsMessage = @"You don’t have any feeds at the moment";
static NSString * const kFeedOptionsMessage = @"Please, choose one";

static const NSInteger kSpacing = 20;
static const NSInteger kSmallSpacing = 10;
static const NSInteger kButtonCornerRadius = 5;
static const NSInteger kZero = 0;
static const NSInteger kOne = 1;
static const float kAnimationDuration = 0.3;

static NSString * const kFeedsReuseIdentifier = @"RSSRChannelCell";
static NSString * const kFeedOptionsReuseIdentifier = @"RSSRChannelOptionCell";

@interface RSSRSettingsController () <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UIButton *findButton;
@property (retain, nonatomic) IBOutlet UITextField *addTextField;
@property (retain, nonatomic) UILabel *noFeedsLabel;
@property (retain, nonatomic) UILabel *feedOptionsLabel;
@property (retain, nonatomic) IBOutlet UILabel *feedsLabel;
@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, retain) UITableView *feedOptionsTableView;
@property (nonatomic, retain) UITableView *feedsTableView;

@property (nonatomic, retain) RSSRChannel *channel;
@property (nonatomic, retain) NSArray<RSSRChannel *> *channelsOptions;
@property (nonatomic, retain) id<RSSFeedsSettingsPresenter> presenter;

@end

@implementation RSSRSettingsController


#pragma mark - Lazy properties

- (UILabel *)noFeedsLabel {
    if (!_noFeedsLabel) {
        _noFeedsLabel = [UILabel new];
        _noFeedsLabel.text = kNoFeedsMessage;
        [_noFeedsLabel setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightLight]];
        [_noFeedsLabel setTextColor:UIColor.lightGrayColor];
        
        _noFeedsLabel.alpha = kZero;
    }
    return _noFeedsLabel;
}

- (UILabel *)feedOptionsLabel {
    if (!_feedOptionsLabel) {
        _feedOptionsLabel = [UILabel new];
        _feedOptionsLabel.text = kFeedOptionsMessage;
        [_feedOptionsLabel setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightLight]];
        [_feedOptionsLabel setTextColor:UIColor.grayColor];
        
        _feedOptionsLabel.alpha = kZero;
    }
    return _feedOptionsLabel;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [UIActivityIndicatorView new];
        _activityIndicator.alpha = kZero;
    }
    return _activityIndicator;
}

- (UITableView *)feedsTableView {
    if (!_feedsTableView) {
        _feedsTableView = [UITableView new];
        _feedsTableView.backgroundColor = UIColor.clearColor;
        _feedsTableView.delegate = self;
        _feedsTableView.dataSource = self;
        _feedsTableView.scrollEnabled = NO;
        _feedsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_feedsTableView registerNib:[UINib nibWithNibName:kFeedsReuseIdentifier
                                                    bundle:nil]
              forCellReuseIdentifier:kFeedsReuseIdentifier];
        
        _feedsTableView.alpha = kZero;
    }
    return _feedsTableView;
}

- (UITableView *)feedOptionsTableView {
    if (!_feedOptionsTableView) {
        _feedOptionsTableView = [RSSRSelfResizedTableView new];
        _feedOptionsTableView.backgroundColor = UIColor.clearColor;
        _feedOptionsTableView.delegate = self;
        _feedOptionsTableView.dataSource = self;
        _feedOptionsTableView.scrollEnabled = NO;
        _feedOptionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_feedOptionsTableView registerNib:[UINib nibWithNibName:kFeedOptionsReuseIdentifier
                                                          bundle:nil]
                    forCellReuseIdentifier:kFeedOptionsReuseIdentifier];
        
        _feedOptionsTableView.alpha = kZero;
    }
    return _feedOptionsTableView;
}


#pragma mark -  Initialization & Deallocation

- (instancetype)initWithPresenter:(id<RSSFeedsSettingsPresenter>)presenter
                          channel:(RSSRChannel *)channel {
    self = [super init];
    if (self) {
        _presenter = [presenter retain];
        [_presenter attachView:self];
        _channel = [channel retain];
    }
    return self;
}

- (void)dealloc {
    [_findButton release];
    [_addTextField release];
    [_feedsLabel release];
    [_activityIndicator release];
    [_presenter release];
    [_channel release];
    [_noFeedsLabel release];
    [_channelsOptions release];
    [_feedOptionsLabel release];
    [_feedOptionsTableView release];
    [_feedsTableView release];
    [super dealloc];
}


#pragma mark - View controller life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kTitle;
    self.findButton.layer.cornerRadius = kButtonCornerRadius;
    
    
    if (self.channel) {
        [self showFeedsTableView];
    } else {
        [self showNoFeedsLabel];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.feedsTableView]) {
        return 1;
    } else {
        return self.channelsOptions.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.feedsTableView]) {
        RSSRChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeedsReuseIdentifier
                                                                forIndexPath:indexPath];
        
        __block typeof(self) weakSelf = self;
        [cell configureWithTitle:self.channel.title deleteHandler:^{
            [weakSelf.presenter deleteChannel];
        }];
        
        return cell;
        
    } else {
        RSSRChannelOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:kFeedOptionsReuseIdentifier
                                                                forIndexPath:indexPath];
        [cell configureWithTitle:self.channelsOptions[indexPath.row].title];
        return cell;
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.feedOptionsTableView]) {
        [self hideFeedOptions];
        [self.presenter saveChannel:self.channelsOptions[indexPath.row]];
        self.channelsOptions = nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


#pragma mark - Show / hide feed options

- (void)showFeedOptions {
    [self.view addSubview:self.feedOptionsTableView];
    [self.view addSubview:self.feedOptionsLabel];
    
    self.feedOptionsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.feedOptionsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.feedOptionsLabel.topAnchor constraintEqualToAnchor:self.addTextField.bottomAnchor constant:kSpacing],
        [self.feedOptionsLabel.leadingAnchor constraintEqualToAnchor:self.feedsLabel.leadingAnchor],
        [self.feedOptionsLabel.trailingAnchor constraintEqualToAnchor:self.feedsLabel.trailingAnchor],
        
        [self.feedOptionsTableView.topAnchor constraintEqualToAnchor:self.feedOptionsLabel.bottomAnchor constant:kSmallSpacing],
        [self.feedOptionsTableView.leadingAnchor constraintEqualToAnchor:self.feedsLabel.leadingAnchor],
        [self.feedOptionsTableView.trailingAnchor constraintEqualToAnchor:self.feedsLabel.trailingAnchor],
        [self.feedsLabel.topAnchor constraintEqualToAnchor:self.feedOptionsTableView.bottomAnchor constant:kSpacing]
    ]];

    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.feedOptionsTableView.alpha = kOne;
        self.feedOptionsLabel.alpha = kOne;
    }];
}

- (void)hideFeedOptions {
    [self.feedOptionsTableView removeFromSuperview];
    [self.feedOptionsLabel removeFromSuperview];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.feedOptionsTableView.alpha = kZero;
        self.feedOptionsLabel.alpha = kZero;
    }];
}


#pragma mark - Show / hide feeds tableview

- (void)showFeedsTableView {
    [self.view addSubview:self.feedsTableView];
    
    self.feedsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.feedsTableView.topAnchor constraintEqualToAnchor:self.feedsLabel.bottomAnchor constant:kSpacing],
        [self.feedsTableView.leadingAnchor constraintEqualToAnchor:self.feedsLabel.leadingAnchor],
        [self.feedsTableView.trailingAnchor constraintEqualToAnchor:self.feedsLabel.trailingAnchor],
        [self.feedsTableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-kSpacing]
    ]];

    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.feedsTableView.alpha = kOne;
    }];
}

- (void)hideFeedsTableView {
    [self.feedsTableView removeFromSuperview];

    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.feedsTableView.alpha = kZero;
    }];
}


#pragma mark - Show / hide noFeedsLabel

- (void)showNoFeedsLabel {
    [self.view addSubview:self.noFeedsLabel];
    
    self.noFeedsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.noFeedsLabel.topAnchor constraintEqualToAnchor:self.feedsLabel.bottomAnchor constant:kSpacing],
        [self.noFeedsLabel.leadingAnchor constraintEqualToAnchor:self.feedsLabel.leadingAnchor],
        [self.noFeedsLabel.trailingAnchor constraintEqualToAnchor:self.feedsLabel.trailingAnchor],
    ]];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.noFeedsLabel.alpha = kOne;
    }];
}

- (void)hideNoFeedsLabel {
    [self.noFeedsLabel removeFromSuperview];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.noFeedsLabel.alpha = kZero;
    }];
}


#pragma mark - Show / hide activity indicator

- (void)showActivitiIndicator {
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
    
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.activityIndicator.topAnchor constraintEqualToAnchor:self.addTextField.bottomAnchor constant:kSpacing],
        [self.activityIndicator.leadingAnchor constraintEqualToAnchor:self.addTextField.leadingAnchor],
        [self.activityIndicator.trailingAnchor constraintEqualToAnchor:self.findButton.trailingAnchor],
        [self.feedsLabel.topAnchor constraintEqualToAnchor:self.activityIndicator.bottomAnchor constant:kSpacing]
    ]];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.activityIndicator.alpha = kOne;
    }];
}

- (void)hideActivitiIndicator {
    [self.activityIndicator removeFromSuperview];
    [self.activityIndicator stopAnimating];
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.activityIndicator.alpha = kZero;
    }];
}


#pragma mark - RSSFeedsSettingsView protocol

- (void)displayFeedsOptions:(NSArray<RSSRChannel *> *)channels {
    self.channelsOptions = channels;
    
    if (![self.view.subviews containsObject:self.feedOptionsTableView]) {
        [self showFeedOptions];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.feedOptionsTableView reloadData];
        });
    }
}

- (void)displayAddedFeed:(RSSRChannel *)channel {
    self.channel = channel;
    
    if (![self.view.subviews containsObject:self.feedsTableView]) {
        [self hideNoFeedsLabel];
        [self showFeedsTableView];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.feedsTableView reloadData];
        });
    }
}

- (void)hideAddedFeed {
    [self hideFeedsTableView];
    [self showNoFeedsLabel];
}


#pragma mark - IBActions

- (IBAction)findFeeds:(id)sender {
    if (![self.addTextField.text isWhitespaceString]) {
        if (![self.activityIndicator isAnimating]) {
            [self showActivitiIndicator];
        }
        [self.presenter retrieveFeedsFromURL:self.addTextField.text];
    }
}


@end
