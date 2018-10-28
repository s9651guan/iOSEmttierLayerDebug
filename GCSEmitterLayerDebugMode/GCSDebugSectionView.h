//
//  GCSDebugSectionView.h
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCSDebugSectionView : UIView

/**
 @param info 属性信息
 @param section 分类名
 */
- (instancetype)initWithValueInfo:(NSDictionary<NSString*, NSValue*> *)info  section:(NSString *)section;

/**
 计算高度

 @return 高度
 */
- (CGFloat)calculateHeight;

@end

NS_ASSUME_NONNULL_END
