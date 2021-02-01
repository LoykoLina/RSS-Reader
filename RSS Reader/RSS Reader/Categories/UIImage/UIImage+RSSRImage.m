//
//  UIImage+RSSRImage.m
//  RSS Reader
//
//  Created by Lina Loyko on 12/20/20.
//

#import "UIImage+RSSRImage.h"

static NSString * const kBackImageName = @"back";
static NSString * const kNextImageName = @"next";
static NSString * const kReloadImageName = @"reload";
static NSString * const kStopImageName = @"stop";
static NSString * const kExploreImageName = @"explore";

@implementation UIImage (RSSRImage)

+ (UIImage *)RSSRBack {
    return [UIImage imageNamed:kBackImageName];
}

+ (UIImage *)RSSRNext {
    return [UIImage imageNamed:kNextImageName];
}

+ (UIImage *)RSSRStop {
    return [UIImage imageNamed:kStopImageName];
}

+ (UIImage *)RSSRReload {
    return [UIImage imageNamed:kReloadImageName];
}

+ (UIImage *)RSSRExplore {
    return [UIImage imageNamed:kExploreImageName];
}

@end
