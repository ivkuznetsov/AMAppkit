//
//  UIResponder+FirstResponder.m
//  BirdseyeMail
//
//  Created by Ilya Kuznecov on 21/12/14.
//  Copyright (c) 2014 Birdseye. All rights reserved.
//

#import "UIResponder+FirstResponder.h"

static __weak id currentFirstResponder;

@implementation UIResponder (FirstResponder)

+ (instancetype)currentFirstResponder {
  currentFirstResponder = nil;
  [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
  return currentFirstResponder;
}

- (void)findFirstResponder:(id)sender {
  currentFirstResponder = self;
}

@end
