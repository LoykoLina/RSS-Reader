//
//  RSSRTopicTableViewCell.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopicTableViewCell.h"
#import "UIColor+RSSRColor.h"
#import "NSDate+StringConversion.h"
#import "RSSRAnnotationButton.h"

static NSString * const kTopicDateFormat = @"MMM d, yyyy HH:mm";
static NSInteger const kCellViewCornerRadius = 10;
static NSString * const kShowMore = @"Show More";
static NSString * const kShowLess = @"Show Less";

@interface RSSRTopicTableViewCell ()

@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *pubDate;
@property (retain, nonatomic) UILabel *summary;
@property (retain, nonatomic) IBOutlet UIView *cellView;
@property (retain, nonatomic) RSSRAnnotationButton *annotationButton;

@property (nonatomic, retain) id<RSSRTopicItemProtocol> topic;

@property (copy, nonatomic) void(^reloadHandler)(id<RSSRTopicItemProtocol> topic);

@end

@implementation RSSRTopicTableViewCell


- (UIButton *)annotationButton {
    if (!_annotationButton) {
        __block typeof(self) weakSelf = self;
        _annotationButton = [[RSSRAnnotationButton alloc] initWithActionBlock:^{
            weakSelf.topic.showDetails = !weakSelf.topic.showDetails;
            weakSelf.reloadHandler(weakSelf.topic);
        }];
    }
    return _annotationButton;
}

- (UILabel *)summary {
    if(!_summary) {
        _summary = [UILabel new];
        _summary.numberOfLines = 0;
        [_summary setFont:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
    }
    return _summary;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cellView.layer.cornerRadius = kCellViewCornerRadius;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.userInteractionEnabled = YES;
}

- (void)dealloc {
    [_title release];
    [_pubDate release];
    [_summary release];
    [_cellView release];
    [_annotationButton release];
    [_topic release];
    [_reloadHandler release];
    [super dealloc];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.cellView.backgroundColor = selected ? UIColor.RSSRSelectedStateColor : UIColor.whiteColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.cellView.backgroundColor = highlighted ? UIColor.RSSRSelectedStateColor : UIColor.whiteColor;
}


- (void)showDetails {
    [self.annotationButton setTitle:kShowLess forState:UIControlStateNormal];
    
    self.summary.text = [self.topic itemSummary];
    [self.cellView addSubview:self.summary];
    
    self.summary.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.summary.topAnchor constraintEqualToAnchor:self.pubDate.bottomAnchor constant:15],
        [self.summary.leadingAnchor constraintEqualToAnchor:self.title.leadingAnchor],
        [self.summary.trailingAnchor constraintEqualToAnchor:self.title.trailingAnchor],
        
        [self.annotationButton.topAnchor constraintEqualToAnchor:self.summary.bottomAnchor constant:10],
    ]];
}

- (void)hideDetails {
    [self.annotationButton setTitle:kShowMore forState:UIControlStateNormal];
    [self.summary removeFromSuperview];
}

- (void)configureWithItem:(id<RSSRTopicItemProtocol>)topic
            reloadHandler:(void(^)(id<RSSRTopicItemProtocol> topic))handler {
    self.reloadHandler = handler;
    self.topic = topic;
    self.title.text = [self.topic itemTitle];
    self.pubDate.text = [[self.topic itemPubDate] stringWithFormat:kTopicDateFormat];
    
    if ([self.topic isPossibleToShowDetails]) {
        [self configureAnnotationButtonLayout];
        
        if (self.topic.showDetails) {
            [self showDetails];
        } else {
            [self hideDetails];
        }
        
        [self setNeedsLayout];
    } else {
        [self.annotationButton removeFromSuperview];
    }
}

- (void)configureAnnotationButtonLayout {
    [self.cellView addSubview:self.annotationButton];
    
    self.annotationButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.annotationButton.heightAnchor constraintEqualToConstant:20],
        [self.annotationButton.widthAnchor constraintEqualToConstant:100],
        [self.annotationButton.topAnchor constraintGreaterThanOrEqualToAnchor:self.pubDate.bottomAnchor constant:10],
        [self.annotationButton.bottomAnchor constraintEqualToAnchor:self.cellView.bottomAnchor constant:-15],
        [self.annotationButton.trailingAnchor constraintEqualToAnchor:self.title.trailingAnchor],
    ]];
}

@end
