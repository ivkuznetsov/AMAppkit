//
//  UIView+SSToolkitAdditions.m
//  SSToolkit
//
//  Created by Sam Soffes on 2/15/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "UIView+SSToolkitAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (SSToolkitAdditions)

- (UIImage *)imageRepresentation {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

- (void)addFadeTransition {
    [self addFadeTransitionWithDuration:0.15f];
}

- (void)addFadeTransitionWithDuration:(CGFloat)duration {
    if ([self.layer animationForKey:@"fade"]) {
        return;
    }
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = duration;
    [self.layer addAnimation:transition forKey:@"fade"];
}

@end
