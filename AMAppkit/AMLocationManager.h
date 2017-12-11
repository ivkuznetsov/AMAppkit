/*
 * Arello Mobile
 * Mobile Framework
 * Except where otherwise noted, this work is licensed under a Creative Commons Attribution 3.0 Unported License
 * http://creativecommons.org/licenses/by/3.0
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_OPTIONS(NSUInteger, LocationManagerOptions) {
    LocationManagerAccess = 1 << 0,
    LocationManagerLocationUpdate = 1 << 1,
    LocationManagerHeadingUpdate = 1 << 2,
};

@interface AMLocationManager : NSObject

@property (nonatomic, readonly) CLLocationManager *locationManager;
@property (nonatomic, readonly) CLHeading *heading;
@property (nonatomic, readonly) CLLocation *location;
@property (nonatomic) BOOL locationFailed;
@property (nonatomic) BOOL cacheLocation;
@property (nonatomic, readonly) CLAuthorizationStatus authorizationStatus;

+ (instancetype)sharedInstance;
+ (BOOL)isValidCoordinate:(CLLocationCoordinate2D)coordinate;
+ (BOOL)locationDetectionPermittedByUser;

- (void)restoreLocation;
- (void)addObserver:(id)observer selector:(SEL)selector options:(LocationManagerOptions)options;
- (void)removeObserver:(id)observer options:(LocationManagerOptions)options;
- (void)updateLocationWithCompletion:(void(^)(NSError *error))completion;

@end