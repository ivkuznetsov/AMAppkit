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
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
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
    transition.fillMode = kCAFillModeBoth;
    [self.layer addAnimation:transition forKey:@"fade"];
}

- (void)addPushTransition {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0 :1.0];
    [self.layer addAnimation:transition forKey:@"transition"];
}

- (void)addPopTransition {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0 :1.0];
    [self.layer addAnimation:transition forKey:@"transition"];
}

- (void)addMoveOutTransition {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0 :1.0];
    [self.layer addAnimation:transition forKey:@"transition"];
}

- (void)addPresentTransition {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0 :1.0];
    [self.layer addAnimation:transition forKey:@"transition"];
}

- (void)addDismissTransition {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0 :0 :1.0];
    [self.layer addAnimation:transition forKey:@"transition"];
}

@end
