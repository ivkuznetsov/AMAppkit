//
//  NSString+Additions.m
//  MobileFramework
//
//  Created by Vladislav Zozulyak on 17.09.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString+Additions.h"

@interface AMMarkupStripper : NSObject <NSXMLParserDelegate> {
    NSMutableArray* _strings;
}

- (NSString*)parse:(NSString*)string;

@end

@implementation AMMarkupStripper

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [_strings addObject:string];
}

- (NSData *)parser:(NSXMLParser *)parser resolveExternalEntityName:(NSString *)entityName systemID:(NSString *)systemID {
    static NSDictionary* entityTable = nil;
    if (!entityTable) {
        entityTable = [[NSDictionary alloc] initWithObjectsAndKeys:
                       [NSData dataWithBytes:" " length:1], @"nbsp",
                       [NSData dataWithBytes:"&" length:1], @"amp",
                       [NSData dataWithBytes:"\"" length:1], @"quot",
                       [NSData dataWithBytes:"<" length:1], @"lt",
                       [NSData dataWithBytes:">" length:1], @"gt",
                       nil];
    }
    return [entityTable objectForKey:entityName];
}

- (NSString*)parse:(NSString*)text {
    _strings = [[NSMutableArray alloc] init];
    
    NSString* document = [NSString stringWithFormat:@"<x>%@</x>", text];
    NSData* data = [document dataUsingEncoding:text.fastestEncoding];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
    return [_strings componentsJoinedByString:@""];
}

@end

@implementation NSString(Additions)

- (NSDate *) dateValueWithFormat: (NSString *) format locale:(NSLocale *) locale {
    return [self dateValueWithFormat:format locale:locale timeZone:[NSTimeZone defaultTimeZone]];
}

- (NSDate *) dateValueWithFormat: (NSString *) format locale:(NSLocale *) locale timeZone:(NSTimeZone *) timeZone {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:format];
    [dateFormatter setLocale:locale];
    [dateFormatter setTimeZone:timeZone];
	NSDate* result = [dateFormatter dateFromString:self];
	
	return result;
}

- (NSDate *) dateValueWithFormat: (NSString *) format {
    return [self dateValueWithFormat:format locale:[NSLocale currentLocale]];
}

- (BOOL)isWhitespace {
    return ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

- (BOOL)isEmptyOrWhitespace {
    return !self.length || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

- (NSString*)stringByRemovingHTMLTags {
    AMMarkupStripper* stripper = [[AMMarkupStripper alloc] init];
    return [stripper parse:self];
}


@end
