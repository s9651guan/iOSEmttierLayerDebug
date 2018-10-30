//
//  GCSValueWindow.h
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/30.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCSValueView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCSValueWindow : UIWindow

+ (GCSValueWindow *)showValueWindow:(NSString *)attribute type:(GCSDebugConditionStyle)style;

@end

NS_ASSUME_NONNULL_END
