//
//  UIView+SSToolkitAdditions.h
//  SSToolkit
//
//  Created by Sam Soffes on 2/15/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SSToolkitAdditions)

- (UIImage *)imageRepresentation;
- (void)addFadeTransition;
- (void)addFadeTransitionWithDuration:(CGFloat)duration;

@end
