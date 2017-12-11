/*
 * Arello Mobile
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import "NSObject+ClassName.h"
#import <objc/runtime.h>

@implementation NSObject(ClassName)

- (NSString *)className {
	return [NSString stringWithUTF8String:class_getName([self class])];
}

+ (NSString *)className {
	return [NSString stringWithUTF8String:class_getName(self)];
}

@end
