//
//  UITableView+Reloading.h
//  AMAppkit
//
//  Created by Ilya Kuznecov on 26/01/2017.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Reloading)

- (void)reloadWithOldData:(NSArray*)oldData newData:(NSArray*)newData block:(dispatch_block_t)block addAnimation:(UITableViewRowAnimation)animation;

@end
