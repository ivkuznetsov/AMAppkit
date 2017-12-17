//
//  AMLocalizedButton.m
//  AMAppkit
//
//  Created by Ilya Kuznecov on 27/01/2017.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

#import "AMLocalizedButton.h"

@implementation AMLocalizedButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //[[AMAppearance appearanceForClass:[self class]] startForwarding:self];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
       // [[AMAppearance appearanceForClass:[self class]] startForwarding:self];
    }
    return self;
}

+ (void)setLocalize:(NSString *(^)(NSString *))localize {
   // [(AMLocalizedButton *)[AMAppearance appearanceForClass:[self class]] setLocalize:localize];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if (_localize) {
        [self setTitle:_localize([self titleForState:UIControlStateNormal]) forState:UIControlStateNormal];
    }
}

@end
