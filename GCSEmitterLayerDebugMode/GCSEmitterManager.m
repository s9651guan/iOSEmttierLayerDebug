//
//  GCSEmitterManager.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSEmitterManager.h"

@interface GCSEmitterManager ()

@end

@implementation GCSEmitterManager

+ (GCSEmitterManager *)sharedManager {
    static GCSEmitterManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GCSEmitterManager alloc]init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
