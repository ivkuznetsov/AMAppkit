/*
 * Arello Mobile
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import "NSString+Validation.h"

@implementation NSString(Validation)

- (BOOL) isValid {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length != 0;
}

- (BOOL) isValidEmail {
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL) isValidDecimal {
    NSString *decimalRegex = @"^(?:|-)(?:|0|[1-9]\\d*)(?:\\.\\d*)?$";
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    return [regexPredicate evaluateWithObject:self];
}

@end