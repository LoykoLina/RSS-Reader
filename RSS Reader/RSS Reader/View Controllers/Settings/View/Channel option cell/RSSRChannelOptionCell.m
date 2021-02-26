//
//  RSSRChannelOptionCell.m
//  RSS Reader
//
//  Created by Lina Loyko on 1/17/21.
//

#import "RSSRChannelOptionCell.h"
#import "UIColor+RSSRColor.h"

static const NSInteger kCornerRadius = 5;

@interface RSSRChannelOptionCell ()

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIView *cellView;

@end

@implementation RSSRChannelOptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellView.layer.cornerRadius = kCornerRadius;
}

- (void)dealloc {
    [_titleLabel release];
    [_cellView release];
    [super dealloc];
}

- (void)configureWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.cellView.backgroundColor = selected ? UIColor.RSSRSelectedStateColor : UIColor.whiteColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.cellView.backgroundColor = highlighted ? UIColor.RSSRSelectedStateColor : UIColor.whiteColor;
}

@end
