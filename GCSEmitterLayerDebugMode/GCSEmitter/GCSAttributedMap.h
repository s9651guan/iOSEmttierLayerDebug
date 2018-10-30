//
//  GCSAttributedMap.h
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/30.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GCSDebugConditionStyle) {
    GCSDebugConditionStyleChooseType = 801,//选择类型
    GCSDebugConditionStyleWriteFloat,//填写浮点型数据
    GCSDebugConditionStyleWriteInt,//填写浮点型数据
    GCSDebugConditionStyleWriteString,//填写字符串
    GCSDebugConditionStyleWriteBool,//填写布尔值
    GCSDebugConditionStyleWriteSize,//填写尺寸
    GCSDebugConditionStyleWritePoint,//填写坐标点
    GCSDebugConditionStyleWriteRect//填写边框
};

@interface GCSAttributedMap : NSObject

+ (NSArray *)typeStringOfAttribute:(NSString *)att;

+ (NSDictionary *)emitterLayerDict;

+ (NSDictionary *)emitterCellDict;

@end

NS_ASSUME_NONNULL_END
