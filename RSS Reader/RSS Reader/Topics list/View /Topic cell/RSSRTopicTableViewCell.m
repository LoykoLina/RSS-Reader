//
//  RSSRTopicTableViewCell.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopicTableViewCell.h"
#import "RSSRTopic.h"
#import "UIColor+RSSRColor.h"

@interface RSSRTopicTableViewCell ()

@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *pubDate;
@property (retain, nonatomic) IBOutlet UILabel *topicDescription;
@property (retain, nonatomic) IBOutlet UIView *cellView;

@end

@implementation RSSRTopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cellView.layer.cornerRadius = 10;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.cellView.backgroundColor = UIColor.RSSRGray;
    } else {
        self.cellView.backgroundColor = UIColor.RSSRWhite;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.cellView.backgroundColor = UIColor.RSSRGray;
    } else {
        self.cellView.backgroundColor = UIColor.RSSRWhite;
    }
}

- (void)configureWithItem:(RSSRTopic *)topic {
    self.title.text = topic.title;
    self.pubDate.text = [topic formattedDate];
    self.topicDescription.text = topic.topicDescription;
}

- (void)dealloc {
    [_title release];
    [_pubDate release];
    [_topicDescription release];
    [_cellView release];
    [super dealloc];
}

@end
