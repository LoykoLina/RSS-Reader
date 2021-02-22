//
//  RSSRAnnotationButton.m
//  RSS Reader
//
//  Created by Lina Loyko on 2/22/21.
//

#import "RSSRAnnotationButton.h"

@interface RSSRAnnotationButton ()

@property (nonatomic, copy) void (^actionBlock)(void);

@end

@implementation RSSRAnnotationButton

- (instancetype)initWithActionBlock:(void (^)(void))actionBlock {
    self = [super init];
    if (self) {
        _actionBlock = [actionBlock copy];
        [self.titleLabel setFont:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
        [self setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
        [self addTarget:self.actionBlock
                 action:@selector(invoke)
       forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)dealloc {
    [_actionBlock release];
    [super dealloc];
}

@end
