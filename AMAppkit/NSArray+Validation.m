/*
 * Arello Mobile
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import "NSArray+Validation.h"


@implementation NSMutableArray(Validation)

- (NSObject *) validObjectAtIndex: (NSInteger) index {
	if ([self objectAtIndex:index] == [NSNull null])
		return nil;
	
	return [self objectAtIndex:index];
}

- (void) addValidObject: (NSObject *) object {
	if (object == nil)
		[self addObject:[NSNull null]];
	else 
		[self addObject:object];
}

- (void) replaceElementAtIndex:(NSInteger) index withValidObject:(NSObject *) validObject {
	if (validObject == nil)
		[self replaceObjectAtIndex:index withObject:[NSNull null]];
	else
		[self replaceObjectAtIndex:index withObject:validObject];
}

@end


@implementation NSMutableArray (WeakReferences)

+ (instancetype) mutableArrayUsingWeakReferences {
	return [self mutableArrayUsingWeakReferencesWithCapacity:0];
}

+ (instancetype) mutableArrayUsingWeakReferencesWithCapacity:(NSUInteger)capacity {
	CFArrayCallBacks callbacks = {0, NULL, NULL, CFCopyDescription, CFEqual};
	return (__bridge_transfer id)(CFArrayCreateMutable(0, capacity, &callbacks));
}

@end