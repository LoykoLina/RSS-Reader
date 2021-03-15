//
//  RSSRSelfResizedTableView.m
//  RSS Reader
//
//  Created by Lina Loyko on 1/17/21.
//

#import "RSSRSelfResizedTableView.h"

@interface RSSRSelfResizedTableView ()

@property (nonatomic, assign) CGFloat maxHeight;

@end

@implementation RSSRSelfResizedTableView

- (CGFloat)maxHeight {
    return UIScreen.mainScreen.bounds.size.height / 2;
}

- (void)reloadData {
    [super reloadData];
    
    [self invalidateIntrinsicContentSize];
    
    [self layoutIfNeeded];
}

- (CGSize)intrinsicContentSize {
    CGFloat height = MIN(self.contentSize.height, self.maxHeight);
    self.scrollEnabled = (height == self.maxHeight);
    return CGSizeMake(self.contentSize.width, height);
}

@end
