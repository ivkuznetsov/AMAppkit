//
//  AMUtils.m
//  AMToolkit
//
//  Created by Ilya Kuznecov on 25/02/16.
//  Copyright © 2016 Ilya Kuznetsov. All rights reserved.
//

#import "AMUtils.h"

@interface AMUtils()

@property (nonatomic) NSMutableDictionary *processingRequests;
@property (nonatomic) dispatch_queue_t queue;

@end

@implementation AMUtils

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _processingRequests = [NSMutableDictionary dictionary];
        _queue = dispatch_queue_create("AMUtils.queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (id)run:(id(^)(SuccessCallback, FailCallback, ProgressCallback))block
  success:(SuccessCallback)runSuccess
  failure:(FailCallback)runFailure
 progress:(ProgressCallback)runProgress
      key:(NSString *)key {
    if (key) {
        
        __block id operation = nil;
        
        dispatch_sync(AMUtils.sharedInstance.queue, ^{
            NSMutableDictionary *dict = [AMUtils sharedInstance].processingRequests[key];
            
            if (dict) {
                [self insertBlock:runSuccess inDict:dict key:@"success"];
                [self insertBlock:runFailure inDict:dict key:@"failure"];
                [self insertBlock:runProgress inDict:dict key:@"progress"];
                operation = dict[@"operation"];
                return;
            }
            
            dict = [NSMutableDictionary dictionary];
            
            [self insertBlock:runSuccess inDict:dict key:@"success"];
            [self insertBlock:runFailure inDict:dict key:@"failure"];
            [self insertBlock:runProgress inDict:dict key:@"progress"];
            
            [AMUtils sharedInstance].processingRequests[key] = dict;
        });
        
        if (operation) {
            return operation;
        }
            
        operation = block( ^(id object){
            __block NSArray *blocks = nil;
            dispatch_sync(AMUtils.sharedInstance.queue, ^{
                NSDictionary *dict = [AMUtils sharedInstance].processingRequests[key];
                blocks = [dict[@"success"] copy];
                [AMUtils sharedInstance].processingRequests[key] = nil;
            });
            
            for (void(^block)(id) in blocks) {
                block(object);
            }
            
        }, ^(id object, NSError *error){
            __block NSArray *blocks = nil;
            dispatch_sync(AMUtils.sharedInstance.queue, ^{
                NSDictionary *dict = [AMUtils sharedInstance].processingRequests[key];
                blocks = [dict[@"failure"] copy];
                [AMUtils sharedInstance].processingRequests[key] = nil;
            });
            
            for (void(^block)(id, NSError*) in blocks) {
                block(object, error);
            }
            
        }, ^(double progress){
            
            __block NSArray *blocks = nil;
            dispatch_sync(AMUtils.sharedInstance.queue, ^{
                NSDictionary *dict = [AMUtils sharedInstance].processingRequests[key];
                blocks = [dict[@"progress"] copy];
            });
            
            for (void(^block)(CGFloat) in blocks) {
                block(progress);
            }
        });

        dispatch_sync(AMUtils.sharedInstance.queue, ^{
            NSMutableDictionary *dict = [AMUtils sharedInstance].processingRequests[key];
            if (operation) {
                dict[@"operation"] = operation;
            }
        });
        
        return operation;
    } else {
        return block( ^(id object){
            if (runSuccess) {
                runSuccess(object);
            }
        }, ^(id object, NSError *error){
            if (runFailure) {
                runFailure(object, error);
            }
        }, ^(double progress){
            if (runProgress) {
                runProgress(progress);
            }
        });
    }
}

+ (NSOperation *)run:(NSOperation *(^)(SuccessCallback, FailCallback))block success:(SuccessCallback)runSuccess failure:(FailCallback)runFailure key:(NSString *)key {
    return [self run:^id(SuccessCallback success, FailCallback fail, ProgressCallback progress) {
        return block(success, fail);
    } success:runSuccess failure:runFailure progress:nil key:key];
}

+ (void)insertBlock:(id)block inDict:(NSMutableDictionary*)dict key:(NSString*)key {
    NSMutableArray *blocks = dict[key];
    if (!blocks) {
        blocks = [NSMutableArray array];
        dict[key] = blocks;
    }
    if (block && ![blocks containsObject:block]) {
        [blocks addObject:block];
    }
}

@end
