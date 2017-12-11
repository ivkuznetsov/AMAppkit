//
//  UIResponder+FirstResponder.h
//  BirdseyeMail
//
//  Created by Ilya Kuznecov on 21/12/14.
//  Copyright (c) 2014 Birdseye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (FirstResponder)

+ (instancetype) currentFirstResponder NS_EXTENSION_UNAVAILABLE_IOS("not available in extension");

@end
