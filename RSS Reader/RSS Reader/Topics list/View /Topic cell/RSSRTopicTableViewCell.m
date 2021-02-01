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
@property (retain, nonatomic) IBOutlet UILabel *pubDate;
@property (retain, nonatomic) IBOutlet UILabel *summary;
@property (retain, nonatomic) IBOutlet UIView *cellView;

@end

@implementation RSSRTopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cellView.layer.cornerRadius = kCellViewCornerRadius;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.cellView.backgroundColor = selected ? UIColor.RSSRSelectedStateColor : UIColor.whiteColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.cellView.backgroundColor = highlighted ? UIColor.RSSRSelectedStateColor : UIColor.whiteColor;
}

- (void)configureWithItem:(id<RSSRTopicItemProtocol>)topic {
    self.title.text = [topic itemTitle];
    self.pubDate.text = [[topic itemPubDate] stringWithFormat:kTopicDateFormat];
    self.summary.text = [topic itemSummary];
}

- (void)dealloc {
    [_title release];
    [_pubDate release];
    [_summary release];
    [_cellView release];
    [super dealloc];
}

@end
