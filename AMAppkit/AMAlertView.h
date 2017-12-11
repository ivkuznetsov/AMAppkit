/*
 * Arello Mobile
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^AMAlertCompletionBlock) (NSInteger cancelIndex, NSInteger firstOtherIndex, NSInteger buttonIndex);
typedef void (^AMAlertTextCompletionBlock) (NSInteger cancelIndex, NSInteger firstOtherIndex, NSInteger buttonIndex, NSString* text);
typedef void (^AMActionSheetCompletionBlock) (NSInteger destructiveIndex, NSInteger cancelIndex, NSInteger firstOtherIndex, NSInteger buttonIndex);

@interface AMAlertView : NSObject

// each method returns either of UIAlertController, UIAlertView or UIActionSheet, depends on iOS version

+ (id)alertWithMessage:(NSString *)message NS_EXTENSION_UNAVAILABLE_IOS("use with controller:");
+ (id)alertWithMessage:(NSString *)message controller:(UIViewController *)controller;

+ (id)alertWithTitle:(NSString *)title message:(NSString *)message NS_EXTENSION_UNAVAILABLE_IOS("use with controller:");
+ (id)alertWithTitle:(NSString *)title message:(NSString *)message controller:(UIViewController *)controller;

+ (id)alertWithMessage:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButton
     otherButtonTitles:(NSArray*)otherButtonTitles
           resultBlock:(AMAlertCompletionBlock)resultBlock NS_EXTENSION_UNAVAILABLE_IOS("use with controller:");

+ (id)alertWithMessage:(NSString *)message
     cancelButtonTitle:(NSString *)cancelButton
     otherButtonTitles:(NSArray *)otherButtonTitles
            controller:(UIViewController *)controller
           resultBlock:(AMAlertCompletionBlock)resultBlock;

+ (id)alertWithTitle:(NSString *)title
             message:(NSString *)message
   cancelButtonTitle:(NSString *)cancelButton
   otherButtonTitles:(NSArray *)otherButtonTitles
         resultBlock:(AMAlertCompletionBlock)resultBlock NS_EXTENSION_UNAVAILABLE_IOS("use with controller:");

+ (id)alertWithTitle:(NSString *)title
             message:(NSString *)message
   cancelButtonTitle:(NSString *)cancelButton
   otherButtonTitles:(NSArray *)otherButtonTitles
          controller:(UIViewController *)controller
         resultBlock:(AMAlertCompletionBlock)resultBlock;

+ (id)textFieldAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                  initialText:(NSString *)initialText
            cancelButtonTitle:(NSString *)cancelButton
                      secured:(BOOL)secured
            otherButtonTitles:(NSArray *)otherButtonTitles
                  resultBlock:(AMAlertTextCompletionBlock)resultBlock NS_EXTENSION_UNAVAILABLE_IOS("use with controller:");;

+ (id)textFieldAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                  initialText:(NSString *)initialText
            cancelButtonTitle:(NSString *)cancelButton
                      secured:(BOOL)secured
            otherButtonTitles:(NSArray *)otherButtonTitles
                   controller:(UIViewController *)controller
                  resultBlock:(AMAlertTextCompletionBlock)resultBlock;

+ (id)actionSheetWithTitle:(NSString *)title
         cancelButtonTitle:(NSString *)cancelButton
    destructiveButtonIndex:(NSInteger)destructiveIndex
         otherButtonTitles:(NSArray *)otherButtonTitles
                      view:(UIView *)view
                      rect:(CGRect)rect
               resultBlock:(AMActionSheetCompletionBlock)resultBlock;

+ (id)actionSheetWithTitle:(NSString *)title
         cancelButtonTitle:(NSString *)cancelButton
    destructiveButtonIndex:(NSInteger)destructiveIndex
         otherButtonTitles:(NSArray *)otherButtonTitles
                      view:(UIView *)view
                      rect:(CGRect)rect
                controller:(UIViewController *)controller
               resultBlock:(AMActionSheetCompletionBlock)resultBlock;

+ (id)actionSheetWithTitle:(NSString *)title
         cancelButtonTitle:(NSString *)cancelButton
    destructiveButtonIndex:(NSInteger)destructiveIndex
         otherButtonTitles:(NSArray *)otherButtonTitles
             barButtonItem:(UIBarButtonItem *)barButtonItem
               resultBlock:(AMActionSheetCompletionBlock)resultBlock;

+ (id)actionSheetWithTitle:(NSString *)title
         cancelButtonTitle:(NSString *)cancelButton
    destructiveButtonIndex:(NSInteger)destructiveIndex
         otherButtonTitles:(NSArray *)otherButtonTitles
             barButtonItem:(UIBarButtonItem *)barButtonItem
                controller:(UIViewController *)controller
               resultBlock:(AMActionSheetCompletionBlock)resultBlock;

@end
