//
//  AMLocalizedLabel.h
//  AMAppkit
//
//  Created by Ilya Kuznecov on 27/01/2017.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMLocalizedLabel : UILabel

@property (nonatomic) NSString *(^localize)(NSString *text);

+ (void)setLocalize:(NSString *(^)(NSString *text))localize;

@end
