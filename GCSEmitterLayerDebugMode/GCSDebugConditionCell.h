//
//  GCSDebugConditionCell.h
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GCSDebugConditionCellSeletedStyle) {
    GCSDebugConditionCellSeletedStyleChooseType = 801,//选择类型
    GCSDebugConditionCellSeletedStyleWriteFloat,//填写浮点型数据
    GCSDebugConditionCellSeletedStyleWriteString,//填写字符串
    GCSDebugConditionCellSeletedStyleWriteBool,//填写布尔值
    GCSDebugConditionCellSeletedStyleWriteSize,//填写尺寸
    GCSDebugConditionCellSeletedStyleWritePoint,//填写坐标点
    GCSDebugConditionCellSeletedStyleWriteRect//填写边框
};

@interface GCSDebugConditionCell : UITableViewCell

/**
 选中响应模式
 */
@property (nonatomic, assign) GCSDebugConditionCellSeletedStyle seletedStyle;

/**
 更新内容

 @param value 属性值
 @param style 选中响应类型
 */
- (void)updateWithValue:(NSString *)value seletedStyle:(GCSDebugConditionCellSeletedStyle)style;

@end

NS_ASSUME_NONNULL_END
