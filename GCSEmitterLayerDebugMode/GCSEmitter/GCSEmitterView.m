//
//  GCSEmitterView.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSEmitterView.h"
#import "GCSEmitterManager.h"

@interface GCSEmitterView ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@property (nonatomic, copy) NSArray *nameList;//CAEmitterCell.name数组

@property (nonatomic, strong) GCSEmitterManager *manager;

@end

@implementation GCSEmitterView

- (GCSEmitterManager *)manager {
    return [GCSEmitterManager sharedManager];
}

- (CAEmitterLayer *)emitterLayer {
    if (!_emitterLayer) {
        _emitterLayer = [CAEmitterLayer layer];
        _emitterLayer.borderWidth = 5.f;
        
        _emitterLayer.frame = self.bounds;
    }
    return _emitterLayer;
}

- (CAEmitterCell *)createEmitterCellWithImage:(UIImage *)image name:(NSString *)name {
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = name;
    //粒子产生率(/秒）
    cell.birthRate = self.manager.birthRate;
    //粒子生命周期
    cell.lifetime = self.manager.lifetime;
    //粒子生命周期改变范围
    cell.lifetimeRange = self.manager.lifetimeRange;
    
    cell.emissionLatitude = self.manager.emissionLatitude;
    //发射角度
    cell.emissionLongitude = self.manager.emissionLongitude;
    //发射角度范围
    cell.emissionRange = self.manager.emissionRange;
    //粒子发射速度
    cell.velocity = self.manager.velocity;
    //粒子速度改变范围
    cell.velocityRange = self.manager.velocityRange;
    cell.xAcceleration = self.manager.xAcceleration;
    //y轴加速度
    cell.yAcceleration = self.manager.yAcceleration;
    cell.zAcceleration = self.manager.zAcceleration;
    //粒子缩放比例
    cell.scale = self.manager.scale;
    cell.scaleRange = self.manager.scaleRange;
    cell.scaleSpeed = self.manager.scaleSpeed;
    //粒子旋转速度
    cell.spin = self.manager.spin;
    //粒子旋转速度改变范围
    cell.spinRange = self.manager.spinRange;
    //粒子透明度范围
    cell.alphaRange = self.manager.alphaRange;
    //粒子透明度变化速度
    cell.alphaSpeed = self.manager.alphaSpeed;
    //粒子图片
    cell.contents = (__bridge id _Nullable)(image.CGImage);
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.layer addSublayer:self.emitterLayer];
}

- (void)updateEmitterLayer {
    
    self.emitterLayer.emitterPosition = self.manager.emitterPosition;
    self.emitterLayer.emitterZPosition = self.manager.emitterZPosition;
    //发射尺寸
    self.emitterLayer.emitterSize = self.manager.emitterSize;
    self.emitterLayer.emitterDepth = self.manager.emitterDepth;
    
    //发射形状
    self.emitterLayer.emitterShape = self.manager.emitterShape;
    //发射模式
    self.emitterLayer.emitterMode = self.manager.emitterMode;
    self.emitterLayer.renderMode = self.manager.renderMode;
    self.emitterLayer.preservesDepth = self.manager.preservesDepth;
    self.emitterLayer.seed = (unsigned int)self.manager.seed;
    
    NSMutableArray *cells = [NSMutableArray array];
    for (int i = 0; i < self.manager.emitterCellNames.count; i++) {
        NSString *imageName = self.manager.emitterCellNames[i];
        UIImage *image = [UIImage imageNamed:imageName];
        CAEmitterCell *cell = [self createEmitterCellWithImage:image name:imageName];
        [cells addObject:cell];
    }
    self.emitterLayer.emitterCells = cells;
}

@end
