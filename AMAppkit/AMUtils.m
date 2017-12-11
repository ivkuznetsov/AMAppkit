//
//  AMUtils.m
//  AMToolkit
//
//  Created by Ilya Kuznecov on 25/02/16.
//  Copyright © 2016 Arello Mobile. All rights reserved.
//

#import "AMUtils.h"

@interface AMUtils()

@property (strong) NSMutableDictionary *processingRequests;

@end

@implementation AMUtils

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _processingRequests = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (id)run:(id(^)(SuccessCallback, FailCallback, ProgressCallback))block
  success:(SuccessCallback)runSuccess
  failure:(FailCallback)runFailure
 progress:(ProgressCallback)runProgress
      key:(NSString *)key {
    if (key) {
        NSMutableDictionary *dict = [AMUtils sharedInstance].processingRequests[key];
        
        if (dict) {
            [self insertBlock:runSuccess inDict:dict key:@"success"];
            [self insertBlock:runFailure inDict:dict key:@"failure"];
            [self insertBlock:runProgress inDict:dict key:@"progress"];
            return dict[@"operation"];
        }
        
        dict = [NSMutableDictionary dictionary];
        
        [self insertBlock:runSuccess inDict:dict key:@"success"];
        [self insertBlock:runFailure inDict:dict key:@"failure"];
        [self insertBlock:runProgress inDict:dict key:@"progress"];
        
        [AMUtils sharedInstance].processingRequests[key] = dict;
        
        id operation = block( ^(id object){
            NSDictionary *dict = [AMUtils sharedInstance].processingRequests[key];
            NSArray *blocks = dict[@"success"];
            for (void(^block)(id) in blocks) {
                block(object);
            }
           
            [AMUtils sharedInstance].processingRequests[key] = nil;
            
        }, ^(id object, NSError *error){
            NSDictionary *dict = [AMUtils sharedInstance].processingRequests[key];
            NSArray *blocks = dict[@"failure"];
            for (void(^block)(id, NSError*) in blocks) {
                block(object, error);
            }
            
            [AMUtils sharedInstance].processingRequests[key] = nil;
            
        }, ^(CGFloat progress){
            
            NSDictionary *dict = [AMUtils sharedInstance].processingRequests[key];
            NSArray *blocks = dict[@"progress"];
            for (void(^block)(CGFloat) in blocks) {
                block(progress);
            }
            
        });

        if (operation) {
            dict[@"operation"] = operation;
        }
        
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
        }, ^(CGFloat progress){
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
