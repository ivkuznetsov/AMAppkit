/*
 * Arello Mobile
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import <Foundation/Foundation.h>


@interface NSMutableArray(Validation)

- (NSObject *) validObjectAtIndex: (NSInteger) index;
- (void) addValidObject: (NSObject *) object;
- (void) replaceElementAtIndex:(NSInteger) index withValidObject:(NSObject *) validObject;

@end


@interface NSMutableArray (WeakReferences)

+ (instancetype) mutableArrayUsingWeakReferences;
+ (instancetype) mutableArrayUsingWeakReferencesWithCapacity:(NSUInteger)capacity;

@end