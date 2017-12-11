/*
 * Arello Mobile
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGPoint)origin {
	return self.frame.origin;
}

- (CGSize)size {
	return self.frame.size;
}

- (CGFloat)x {
	return self.frame.origin.x;
}

- (CGFloat)y {
	return self.frame.origin.y;
}

- (CGFloat)width {
	return self.frame.size.width;
}

- (CGFloat)height {
	return self.frame.size.height;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setOrigin:(CGPoint)newOrigin {
	CGRect selfFrame = self.frame;
	selfFrame.origin = newOrigin;
	self.frame = selfFrame;
}

- (void)setSize:(CGSize)newSize {
	CGRect selfFrame = self.frame;
	selfFrame.size = newSize;
	self.frame = selfFrame;
}

- (void)setX:(CGFloat)newX {
	CGRect selfFrame = self.frame;
	selfFrame.origin.x = newX;
	self.frame = selfFrame;
}

- (void)setY:(CGFloat)newY {
	CGRect selfFrame = self.frame;
	selfFrame.origin.y = newY;
	self.frame = selfFrame;
}

- (void)setWidth:(CGFloat)newWidth {
	CGRect selfFrame = self.frame;
	selfFrame.size.width = newWidth;
	self.frame = selfFrame;
}

- (void)setHeight:(CGFloat)newHeight {
	CGRect selfFrame = self.frame;
	selfFrame.size.height = newHeight;
	self.frame = selfFrame;
}

- (void)setBottom:(CGFloat)bottom {
    self.y = bottom - self.height;
}

- (void)setRight:(CGFloat)right {
    self.x = right - self.width;
}

@end
