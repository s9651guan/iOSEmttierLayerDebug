//
//  GCSAttributedMap.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/30.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSAttributedMap.h"

@implementation GCSAttributedMap

+ (NSArray *)typeStringOfAttribute:(NSString *)att {
    if ([[self typeDict].allKeys containsObject:att]) {
        return [[self typeDict] objectForKey:att];
    }
    return nil;
}

+ (NSDictionary *)typeDict {
    return @{
             @"emitterShape":[self emitterShapeTypeDict],
             @"emitterMode":[self emitterModeTypeDict],
             @"renderMode":[self renderModeTypeDict]
             };
}

+ (NSArray *)emitterShapeTypeDict {
    return @[
             kCAEmitterLayerPoint,
             kCAEmitterLayerLine,
             kCAEmitterLayerRectangle,
             kCAEmitterLayerCuboid,
             kCAEmitterLayerCircle,
             kCAEmitterLayerSphere
             ];
}

+ (NSArray *)emitterModeTypeDict {
    return @[
             kCAEmitterLayerPoints,
             kCAEmitterLayerOutline,
             kCAEmitterLayerSurface,
             kCAEmitterLayerVolume
             ];
}

+ (NSArray *)renderModeTypeDict {
    return @[
             kCAEmitterLayerUnordered,
             kCAEmitterLayerOldestFirst,
             kCAEmitterLayerOldestLast,
             kCAEmitterLayerBackToFront,
             kCAEmitterLayerAdditive
             ];
}

+ (NSDictionary *)emitterLayerDict {
    return @{
             @"emitterPosition":
                 @(GCSDebugConditionStyleWritePoint),
             @"emitterZPosition":
                 @(GCSDebugConditionStyleWritePoint),
             @"emitterSize":
                 @(GCSDebugConditionStyleWriteSize),
             @"emitterDepth":
                 @(GCSDebugConditionStyleWriteFloat),
             @"emitterShape":
                 @(GCSDebugConditionStyleChooseType),
             @"emitterMode":
                 @(GCSDebugConditionStyleChooseType),
             @"renderMode":
                 @(GCSDebugConditionStyleChooseType),
             @"seed":
                 @(GCSDebugConditionStyleWriteInt)
             };
}

+ (NSDictionary *)emitterCellDict {
    return @{
             @"birthRate":
                 @(GCSDebugConditionStyleWriteFloat),
             @"lifetime":
                 @(GCSDebugConditionStyleWriteFloat),
             @"lifetimeRange":
                 @(GCSDebugConditionStyleWriteFloat),
             @"emissionLatitude":
                 @(GCSDebugConditionStyleWriteFloat),
             @"emissionLongitude":
                 @(GCSDebugConditionStyleWriteFloat),
             @"emissionRange":
                 @(GCSDebugConditionStyleWriteFloat),
             @"velocity":
                 @(GCSDebugConditionStyleWriteFloat),
             @"velocityRange":
                 @(GCSDebugConditionStyleWriteFloat),
             @"xAcceleration":
                 @(GCSDebugConditionStyleWriteFloat),
             @"yAcceleration":
                 @(GCSDebugConditionStyleWriteFloat),
             @"zAcceleration":
                 @(GCSDebugConditionStyleWriteFloat),
             @"scale":
                 @(GCSDebugConditionStyleWriteFloat),
             @"scaleRange":
                 @(GCSDebugConditionStyleWriteFloat),
             @"scaleSpeed":
                 @(GCSDebugConditionStyleWriteFloat),
             @"spin":
                 @(GCSDebugConditionStyleWriteFloat),
             @"spinRange":
                 @(GCSDebugConditionStyleWriteFloat),
             @"alphaRange":
                 @(GCSDebugConditionStyleWriteFloat),
             @"alphaSpeed":
                 @(GCSDebugConditionStyleWriteFloat)
             };
}

@end
