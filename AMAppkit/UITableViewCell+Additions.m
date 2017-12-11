/*
 * Arello Mobile
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import "UITableViewCell+Additions.h"
#import "NSObject+ClassName.h"

@implementation UITableViewCell (Additions)

+ (instancetype)createTableViewCell {
	NSString *nibName = [self className];
	return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
}

+ (instancetype)createTableViewCellForTable:(UITableView *)table {
	UITableViewCell *result = [table dequeueReusableCellWithIdentifier:[self className]];
    if (!result) {
		result = [self createTableViewCell];
    }
	return result;
}

@end
