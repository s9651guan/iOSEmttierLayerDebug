//
//  GCSDebugConditionCell.h
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCSAttributedMap.h"
NS_ASSUME_NONNULL_BEGIN

@interface GCSDebugConditionCell : UITableViewCell

/**
 选中响应模式
 */
@property (nonatomic, assign) GCSDebugConditionStyle seletedStyle;

/**
 更新内容

 @param value 属性值
 @param style 选中响应类型
 */
- (void)updateWithValue:(NSString *)value seletedStyle:(GCSDebugConditionStyle)style;

@end

NS_ASSUME_NONNULL_END
