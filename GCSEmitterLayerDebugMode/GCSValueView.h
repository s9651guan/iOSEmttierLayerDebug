//
//  GCSValueView.h
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/29.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GCSValueViewStyle) {
    GCSValueViewStyleChooseType = 801,//选择类型
    GCSValueViewStyleWriteFloat,//填写浮点型数据
    GCSValueViewStyleWriteString,//填写字符串
//    GCSValueViewStyleWriteBool,//填写布尔值
    GCSValueViewStyleWriteSize,//填写尺寸
    GCSValueViewStyleWritePoint,//填写坐标点
    GCSValueViewStyleWriteRect//填写边框
};

@interface GCSValueView : UIView

@property (nonatomic, copy) GCSOneParamBlock doneCallBack;

- (instancetype)initWithAttribute:(NSString *)att style:(GCSValueViewStyle)style;

@end

NS_ASSUME_NONNULL_END
