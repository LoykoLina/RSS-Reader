//
//  RSSRTopicTableViewCell.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopicTableViewCell.h"
#import "UIColor+RSSRColor.h"
#import "NSDate+StringConversion.h"

static NSString * const kTopicDateFormat = @"MMM d, yyyy HH:mm";
static NSInteger const kCellViewCornerRadius = 10;

@interface RSSRTopicTableViewCell ()

@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) UILabel *pubDate;
@property (retain, nonatomic) UILabel *summary;
@property (retain, nonatomic) IBOutlet UIView *cellView;
@property (retain, nonatomic) IBOutlet UIButton *annotationButton;

@property (nonatomic, retain) id<RSSRTopicItemProtocol> topic;
@property (assign, nonatomic) id<RSSRTopicCellDelegate> delegate;

@end

@implementation RSSRTopicTableViewCell

- (UILabel *)pubDate {
    if(!_pubDate) {
        _pubDate = [UILabel new];
        [_pubDate setFont:[UIFont systemFontOfSize:10 weight:UIFontWeightLight]];
        [_pubDate setTextColor:UIColor.darkGrayColor];
    }
    return _pubDate;
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
}

- (void)dealloc {
    [_title release];
    [_pubDate release];
    [_summary release];
    [_cellView release];
    [_annotationButton release];
    [_topic release];
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
    [self.cellView addSubview:self.pubDate];
    [self.cellView addSubview:self.summary];
    
    self.pubDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.summary.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.pubDate.topAnchor constraintEqualToAnchor:self.title.bottomAnchor constant:5],
        [self.pubDate.leadingAnchor constraintEqualToAnchor:self.title.leadingAnchor],
        [self.pubDate.trailingAnchor constraintEqualToAnchor:self.title.trailingAnchor],
        
        [self.summary.topAnchor constraintEqualToAnchor:self.pubDate.bottomAnchor constant:10],
        [self.summary.leadingAnchor constraintEqualToAnchor:self.title.leadingAnchor],
        [self.summary.trailingAnchor constraintEqualToAnchor:self.title.trailingAnchor],
        
        [self.annotationButton.topAnchor constraintEqualToAnchor:self.summary.bottomAnchor constant:5],
    ]];
}

- (void)hideDetails {
    [self.pubDate removeFromSuperview];
    [self.summary removeFromSuperview];
}

- (void)configureWithItem:(id<RSSRTopicItemProtocol>)topic
                 delegate:(id<RSSRTopicCellDelegate>)delegate {
    self.delegate = delegate;
    self.topic = topic;
    self.title.text = [self.topic itemTitle];
    self.pubDate.text = [[self.topic itemPubDate] stringWithFormat:kTopicDateFormat];
    self.summary.text = [self.topic itemSummary];
    
    if (self.topic.showDetails) {
        [self showDetails];
    }
    else {
        [self hideDetails];
    }
    
    [self setNeedsLayout];
}

- (IBAction)clickOnAnnotation:(id)sender {
    self.topic.showDetails = !self.topic.showDetails;
    [self.delegate reloadCellWithTopic:self.topic];
}



@end
