//
//  GCSEmitterManager.h
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCSEmitterManager : NSObject

//CAEmitterLayer
@property (nonatomic, copy) NSArray *emitterCellNames;
@property (nonatomic, assign) CGPoint emitterPosition;
@property (nonatomic, assign) CGFloat emitterZPosition;
@property (nonatomic, assign) CGSize emitterSize;
@property (nonatomic, assign) CGFloat emitterDepth;
@property (nonatomic, copy) CAEmitterLayerEmitterShape emitterShape;
@property (nonatomic, copy) CAEmitterLayerEmitterMode emitterMode;
@property (nonatomic, copy) CAEmitterLayerRenderMode renderMode;
@property (nonatomic, assign) BOOL preservesDepth;
@property (nonatomic, assign) NSUInteger seed;

//CAEmitterCell
@property(nullable, copy) NSString *name;
@property (nonatomic, assign) CGFloat birthRate;
@property (nonatomic, assign) CGFloat lifetime;
@property (nonatomic, assign) CGFloat lifetimeRange;
@property (nonatomic, assign) CGFloat emissionLatitude;
@property (nonatomic, assign) CGFloat emissionLongitude;
@property (nonatomic, assign) CGFloat emissionRange;
@property (nonatomic, assign) CGFloat velocity;
@property (nonatomic, assign) CGFloat velocityRange;
@property (nonatomic, assign) CGFloat xAcceleration;
@property (nonatomic, assign) CGFloat yAcceleration;
@property (nonatomic, assign) CGFloat zAcceleration;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat scaleRange;
@property (nonatomic, assign) CGFloat scaleSpeed;
@property (nonatomic, assign) CGFloat spin;
@property (nonatomic, assign) CGFloat spinRange;
@property (nonatomic, assign) CGFloat alphaRange;
@property (nonatomic, assign) CGFloat alphaSpeed;
+ (GCSEmitterManager *)sharedManager;

@end

NS_ASSUME_NONNULL_END
