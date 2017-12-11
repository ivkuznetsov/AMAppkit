//
//  UITableView+Reloading.m
//  AMAppkit
//
//  Created by Ilya Kuznecov on 26/01/2017.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

#import "UITableView+Reloading.h"

@implementation UITableView (Reloading)

- (void)reloadWithOldData:(NSArray*)oldData newData:(NSArray*)newData block:(dispatch_block_t)block addAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray *deleteIndexPaths = [NSMutableArray array];
    
    NSSet *oldDataSet = [NSSet setWithArray:oldData];
    NSSet *newDataSet = [NSSet setWithArray:newData];
    
    for (NSUInteger index = 0; index < oldData.count; index++) {
        if (![newDataSet containsObject:oldData[index]]) {
            [deleteIndexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        }
    }
    NSMutableArray *addIndexPaths = [NSMutableArray array];
    for (NSUInteger index = 0; index < newData.count; index++) {
        if (![oldDataSet containsObject:newData[index]]) {
            [addIndexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        }
    }
    
    [self beginUpdates];
    
    if (deleteIndexPaths.count) {
        [self deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    if (addIndexPaths.count) {
        [self insertRowsAtIndexPaths:addIndexPaths withRowAnimation:animation];
    }
    
    if (block) {
        block();
    }
    [self endUpdates];
}

@end
