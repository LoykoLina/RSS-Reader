//
//  RSSRChannelCell.m
//  RSS Reader
//
//  Created by Lina Loyko on 1/13/21.
//

#import "RSSRChannelCell.h"

static const NSInteger kCornerRadius = 5;

@interface RSSRChannelCell ()

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIView *cellView;
@property (copy, nonatomic) void(^deleteHandler)(void);

@end

@implementation RSSRChannelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellView.layer.cornerRadius = kCornerRadius;
}

- (void)configureWithTitle:(NSString *)title deleteHandler:(void(^)(void))handler {
    self.titleLabel.text = title;
    self.deleteHandler = handler;
}

- (void)dealloc {
    [_titleLabel release];
    [_cellView release];
    [_deleteHandler release];
    [super dealloc];
}

- (IBAction)deleteChannel:(id)sender {
    self.deleteHandler();
}

@end
