//
//  Created by Anton Kaizer on 21.07.12.
//

#import <Foundation/Foundation.h>

typedef id(^AMObjectConverter)(id obj);
typedef BOOL(^AMPredicateBlock)(id obj);
typedef NSInteger(^AMWeightBlock)(id obj);
typedef BOOL(^AMSimpleComparator)(id obj1, id obj2);

@interface NSArray (Additions)

- (NSArray *)arrayByJoiningSubarrays:(NSArray *(^)(id obj))subArrayBlock;
- (NSArray *) arrayWithConverter:(AMObjectConverter) converter;
- (NSArray *) filteredArrayUsingBlock:(AMPredicateBlock) block;
- (NSArray *) sortedArrayWithWeightBlock:(AMWeightBlock) block;
- (id) firstObjectPassedPredicateBlock:(AMPredicateBlock) block;
+ (BOOL) compareArray:(NSArray *) array1 withArray:(NSArray *) array2 usingComparatorBlock:(AMSimpleComparator) block;
- (NSArray *) arrayByRemovingObjectsFromArray:(NSArray *) array;
- (BOOL) containsObject:(id)anObject passedComparator:(AMSimpleComparator) block;

+ (NSArray*) shuffledArrayFromArray:(NSArray*)array;

@end
