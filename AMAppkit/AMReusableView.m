//
//  AMReusableView.m
//  AMAppkit
//
//  Created by Ilya Kuznecov on 27/01/2017.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

#import "AMReusableView.h"

@implementation AMReusableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        UIView *view = nil;
        
        for (UIView *object in [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil]) {
            if ([object isKindOfClass:[UIView class]]) {
                view = object;
                break;
            }
        }
        view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self insertSubview:view atIndex:0];
        self.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

@end
