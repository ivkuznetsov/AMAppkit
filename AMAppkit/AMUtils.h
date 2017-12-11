//
//  AMUtils.h
//  AMToolkit
//
//  Created by Ilya Kuznecov on 25/02/16.
//  Copyright © 2016 Arello Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SuccessCallback)(id object);
typedef void (^FailCallback)(id object, NSError *requestError);
typedef void (^ProgressCallback)(CGFloat progress);

@interface AMUtils : NSObject

+ (NSOperation *)run:(NSOperation *(^)(SuccessCallback, FailCallback))block success:(SuccessCallback)runSuccess failure:(FailCallback)runFailure key:(NSString *)key;

+ (id)run:(id(^)(SuccessCallback, FailCallback, ProgressCallback))block
  success:(SuccessCallback)runSuccess
  failure:(FailCallback)runFailure
 progress:(ProgressCallback)runProgress
      key:(NSString *)key;

@end
