/*
 * Ilya Kuznetsov
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import <Foundation/Foundation.h>

@interface NSDate(FormatExtensions)

+ (NSDate*) dateFromString:(NSString*)string withFormat:(NSString*)format;
- (NSString*) stringValueWithFormat:(NSString*)format;
- (NSString*) stringValueWithStyle:(NSDateFormatterStyle)style;
- (NSInteger) weekDay;

- (NSDate*) dateWithoutTimeComponent;
- (NSDate*) dateWithoutYearComponent;

+ (NSDate*) dateWithoutTimeComponent;

- (NSDate*) dayEndTime;

+ (NSDate*) yearBeginDateForYear:(NSInteger) year;
+ (NSDate*) yearEndDateForYear:(NSInteger) year;

+ (NSDate*) yearBeginDate;
+ (NSDate*) yearEndDate;

+ (NSDate*) monthBeginDateForMonth:(NSInteger) month;
+ (NSDate*) monthEndDateForMonth:(NSInteger) month;

+ (NSDate*) monthBeginDate;
+ (NSDate*) monthEndDate;

- (NSDate*) monthBeginDate;
- (NSDate*) monthEndDate;

+ (NSDate*) weekBeginDateForWeek:(NSInteger) week;
+ (NSDate*) weekEndDateForWeek:(NSInteger) week;

+ (NSDate*) weekBeginDate;
+ (NSDate*) weekEndDate;

- (NSInteger) day;
- (NSInteger) week;
- (NSInteger) month;
- (NSInteger) year;

- (NSInteger) hour;
- (NSInteger) minute;
- (NSInteger) second;

- (NSDateComponents *)components;
- (NSDate*) dateByAddingDays:(NSInteger) day;
- (NSDate*) dateByAddingMonths:(NSInteger) months;
- (NSDate*) dateByAddingYears:(NSInteger) years;

@end
