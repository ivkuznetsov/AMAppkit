//
//  NSString+Additions.h
//  Mobile
//  Created by Vladislav Zozulyak on 17.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString(Additions)

- (NSDate *) dateValueWithFormat: (NSString *) format;
- (NSDate *) dateValueWithFormat: (NSString *) format locale:(NSLocale *) locale;
- (NSDate *) dateValueWithFormat: (NSString *) format locale:(NSLocale *) locale timeZone:(NSTimeZone *) timeZone;

/**
 * Determines if the string contains only whitespace.
 */
- (BOOL)isWhitespace;

/**
 * Determines if the string is empty or contains only whitespace.
 */
- (BOOL)isEmptyOrWhitespace;

/**
 * Returns a string with all HTML tags removed.
 */
- (NSString*)stringByRemovingHTMLTags;

@end
