//
//  AMAppkit.h
//  AMAppkit
//
//  Created by Ilya Kuznecov on 25/01/2017.
//  Copyright © 2017 Ilya Kuznetsov. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for AMAppkit.
FOUNDATION_EXPORT double AMAppkitVersionNumber;

//! Project version string for AMAppkit.
FOUNDATION_EXPORT const unsigned char AMAppkitVersionString[];

#import <AMAppkit/AMInputHelper.h>
#import <AMAppkit/AMAppkitDefines.h>
#import <AMAppkit/AMAppkitObjC.h>

//tools
#import <AMAppkit/AMUtils.h>
#import <AMAppkit/AMLocationManager.h>

#import <AMAppkit/UIImageView+WebCache.h>
#import <AMAppkit/UIButton+WebCache.h>
#import <AMAppkit/MKAnnotationView+WebCache.h>
#import <AMAppkit/UIView+WebCacheOperation.h>
#import <AMAppkit/UIImageView+HighlightedWebCache.h>
#import <AMAppkit/UIImage+MultiFormat.h>
#import <AMAppkit/UIImage+GIF.h>
#import <AMAppkit/SDWebImagePrefetcher.h>
#import <AMAppkit/SDAnimatedImageRep.h>
#import <AMAppkit/SDImageCache.h>
#import <AMAppkit/SDDiskCache.h>
#import <AMAppkit/SDImageIOCoder.h>
#import <AMAppkit/SDImageGraphics.h>
#import <AMAppkit/SDImageCachesManager.h>
#import <AMAppkit/SDWebImageTransition.h>
#import <AMAppkit/SDImageFrame.h>
#import <AMAppkit/SDImageGIFCoder.h>
#import <AMAppkit/UIImage+MemoryCacheCost.h>
#import <AMAppkit/UIImage+Metadata.h>
#import <AMAppkit/SDImageLoadersManager.h>
#import <AMAppkit/UIImage+ForceDecode.h>
#import <AMAppkit/SDImageCoderHelper.h>
#import <AMAppkit/SDImageAPNGCoder.h>
#import <AMAppkit/SDWebImageError.h>
#import <AMAppkit/SDMemoryCache.h>
#import <AMAppkit/SDImageCodersManager.h>
#import <AMAppkit/UIView+WebCache.h>
#import <AMAppkit/SDAnimatedImageView+WebCache.h>
#import <AMAppkit/SDWebImageDownloaderOperation.h>
#import <AMAppkit/NSData+ImageContentType.h>

//table helper
#import <AMAppkit/UITableViewCell+Additions.h>

//collection helper
#import <AMAppkit/UICollectionView+Reloading.h>

//custom views
#import <AMAppkit/AMLinkLabel.h>
#import <AMAppkit/AMPreviewScrollView.h>
#import <AMAppkit/AMLocalizedLabel.h>
#import <AMAppkit/AMLocalizedButton.h>
#import <AMAppkit/AMReusableView.h>
#import <AMAppkit/AMUntouchableView.h>

//additions
#import <AMAppkit/UIView+Frame.h>
#import <AMAppkit/UIImage+Tint.h>
#import <AMAppkit/UIColor+SSToolkitAdditions.h>
#import <AMAppkit/UIResponder+FirstResponder.h>
#import <AMAppkit/UIApplication+SSToolkitAdditions.h>
#import <AMAppkit/UIView+SSToolkitAdditions.h>
#import <AMAppkit/UIImage+ProportionalFill.h>
#import <AMAppkit/NSString+SSToolkitAdditions.h>
#import <AMAppkit/NSURL+SSToolkitAdditions.h>
#import <AMAppkit/NSArray+Additions.h>
#import <AMAppkit/NSObject+ClassName.h>
#import <AMAppkit/NSArray+Validation.h>
#import <AMAppkit/NSDateAdditions.h>
#import <AMAppkit/NSString+Additions.h>
#import <AMAppkit/NSString+Validation.h>
#import <AMAppkit/NSDictionary+SSToolkitAdditions.h>
#import <AMAppkit/NSData+SSToolkitAdditions.h>
