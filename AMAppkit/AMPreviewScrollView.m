//
//  AMPreviewScrollView.m
//  AMAppkit
//
//  Created by Ilya Kuznecov on 27/01/2017.
//  Copyright © 2017 Arello Mobile. All rights reserved.
//

#import "AMPreviewScrollView.h"

@interface AMPreviewScrollView()<UIScrollViewDelegate>

@end

@implementation AMPreviewScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.clipsToBounds = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.clipsToBounds = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
}

- (void)setImage:(UIImage *)image {
    CGSize size = [self imageSize:image];
    [self setImage:image withAspect:size.height / size.width];
}

- (CGSize)imageSize:(UIImage *)image {
    return CGSizeMake(image.size.width * image.scale,
                      image.size.height * image.scale);
}

- (void)setImage:(UIImage *)image withAspect:(CGFloat)aspect {
    CGSize size = [self imageSize:image];
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.frame = CGRectMake(0, 0, size.width, size.height);
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.layer.allowsEdgeAntialiasing = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height)];
        _containerView.backgroundColor = [UIColor clearColor];
        
        [_containerView addSubview:_imageView];
        [self insertSubview:_containerView atIndex:0];
    } else {
        _imageView.image = image;
    }
    if (image) {
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 1.0;
        self.zoomScale = 1.0;
        [self layoutIfNeeded];
        
        CGFloat scale = [UIScreen mainScreen].scale;
        
        _containerView.frame = CGRectMake(0, 0, size.width / scale, size.height / scale);
        _imageView.frame = _containerView.frame;
        self.contentSize = _imageView.bounds.size;
        [self layoutImageView];
        self.zoomScale = self.minimumZoomScale;
        [self scrollViewDidZoom:self];
    }
}

- (void)layoutImageView {
    if (!_imageView.image) {
        return;
    }
    self.maximumZoomScale = 4.0;
    float aspect = (_containerView.frame.size.width / self.zoomScale) / (_containerView.frame.size.height / self.zoomScale);
    float viewAspect = self.bounds.size.width / self.bounds.size.height;
    if ((!_aspectFill && aspect > viewAspect) || (_aspectFill && aspect < viewAspect)) {
        self.minimumZoomScale = self.bounds.size.width / (_containerView.frame.size.width / self.zoomScale);
    } else {
        self.minimumZoomScale = self.bounds.size.height / (_containerView.frame.size.height / self.zoomScale);
    }
    
    if (self.maximumZoomScale < self.minimumZoomScale) {
        self.maximumZoomScale = self.minimumZoomScale;
    }
    if (self.zoomScale < self.minimumZoomScale) {
        self.zoomScale = self.minimumZoomScale;
    }
    if (self.zoomScale > self.maximumZoomScale) {
        self.zoomScale = self.maximumZoomScale;
    }
}

- (void)setFrame:(CGRect)frame {
    CGSize oldSize = self.frame.size;
    [super setFrame:frame];
    if (!CGSizeEqualToSize(frame.size, oldSize)) {
        [self layoutImageView];
        self.zoomScale = self.minimumZoomScale;
        [self scrollViewDidZoom:self];
    }
}

- (void)setBounds:(CGRect)bounds {
    CGSize oldSize = self.bounds.size;
    [super setBounds:bounds];
    if (!CGSizeEqualToSize(bounds.size, oldSize)) {
        [self layoutImageView];
        [self scrollViewDidZoom:self];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat top = 0, left = 0;
    if (self.contentSize.width < self.bounds.size.width) {
        left = (self.bounds.size.width - self.contentSize.width) * 0.5f;
    }
    if (self.contentSize.height < self.bounds.size.height) {
        top = (self.bounds.size.height - self.contentSize.height) * 0.5f;
    }
    scrollView.contentInset = UIEdgeInsetsMake(top, left, top, left);
}

@end
