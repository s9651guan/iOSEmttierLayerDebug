//
//  GCSValueView.h
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/29.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCSAttributedMap.h"
NS_ASSUME_NONNULL_BEGIN

@interface GCSValueView : UIView

@property (nonatomic, copy) GCSOneParamBlock doneCallBack;

- (instancetype)initWithAttribute:(NSString *)att style:(GCSDebugConditionStyle)style;

- (CGFloat)calculateHeight;

@end

NS_ASSUME_NONNULL_END
