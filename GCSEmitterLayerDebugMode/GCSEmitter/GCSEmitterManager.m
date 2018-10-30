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

- (void)updateAttribute:(NSString *)att value:(id)value {
    if ([value isKindOfClass:[NSValue class]]) {
        NSValue *_value = (NSValue *)value;
        if ([att isEqualToString:@"emitterPosition"]) {
            self.emitterPosition = _value.CGPointValue;
        } else if ([att isEqualToString:@"emitterSize"]) {
            self.emitterSize = _value.CGSizeValue;
        }
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString *_value = (NSString *)value;
        if ([att isEqualToString:@"emitterZPosition"]) {
            self.emitterZPosition = _value.floatValue;
        } else if ([att isEqualToString:@"emitterDepth"]) {
            self.emitterDepth = _value.floatValue;
        } else if ([att isEqualToString:@"seed"]) {
            self.seed = _value.floatValue;
        } else if ([att isEqualToString:@"birthRate"]) {
            self.birthRate = _value.floatValue;
        } else if ([att isEqualToString:@"lifetime"]) {
            self.lifetime = _value.floatValue;
        } else if ([att isEqualToString:@"lifetimeRange"]) {
            self.lifetimeRange = _value.floatValue;
        } else if ([att isEqualToString:@"emissionLatitude"]) {
            self.emissionLatitude = _value.floatValue;
        } else if ([att isEqualToString:@"emissionLongitude"]) {
            self.emissionLongitude = _value.floatValue;
        } else if ([att isEqualToString:@"emissionRange"]) {
            self.emissionRange = _value.floatValue;
        } else if ([att isEqualToString:@"velocity"]) {
            self.velocity = _value.floatValue;
        } else if ([att isEqualToString:@"velocityRange"]) {
            self.velocityRange = _value.floatValue;
        } else if ([att isEqualToString:@"xAcceleration"]) {
            self.xAcceleration = _value.floatValue;
        } else if ([att isEqualToString:@"yAcceleration"]) {
            self.yAcceleration = _value.floatValue;
        } else if ([att isEqualToString:@"zAcceleration"]) {
            self.zAcceleration = _value.floatValue;
        } else if ([att isEqualToString:@"scale"]) {
            self.scale = _value.floatValue;
        } else if ([att isEqualToString:@"scaleRange"]) {
            self.scaleRange = _value.floatValue;
        } else if ([att isEqualToString:@"scaleSpeed"]) {
            self.scaleSpeed = _value.floatValue;
        } else if ([att isEqualToString:@"spin"]) {
            self.spin = _value.floatValue;
        } else if ([att isEqualToString:@"spinRange"]) {
            self.spinRange = _value.floatValue;
        } else if ([att isEqualToString:@"alphaRange"]) {
            self.alphaRange = _value.floatValue;
        } else if ([att isEqualToString:@"alphaSpeed"]) {
            self.alphaSpeed = _value.floatValue;
        }

    } else if ([value isKindOfClass:[NSNumber class]]) {
        if ([att isEqualToString:@"emitterShape"]) {
            self.emitterShape = value;
        } else if ([att isEqualToString:@"emitterMode"]) {
            self.emitterMode = value;
        } else if ([att isEqualToString:@"renderMode"]) {
            self.renderMode = value;
        }
    }
    
}

@end
