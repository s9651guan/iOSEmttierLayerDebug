//
//  GCSDebugView.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSDebugView.h"
#import "GCSDebugSectionView.h"

@interface GCSDebugView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation GCSDebugView

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.frame = CGRectMake(GCS_SCREENW / 6,
                            GCS_SCREENH / 5 ,
                            GCS_SCREENW * 2 / 3,
                            GCS_SCREENH / 2);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self addSubview:self.scrollView];
    self.scrollView.frame = self.bounds;
    
    CGFloat y = 0;
    CGFloat width = self.bounds.size.width;
    
    NSDictionary *dict = @{
                           @"aaa":@(801),
                           @"bbb":@(802),
                           @"ccc":@(803),
                           @"ddd":@(804),
                           @"aaaq":@(801),
                           @"bbba":@(802),
                           @"cccq":@(803),
                           @"dddd":@(804),
                           @"aaae":@(801),
                           @"bbbe":@(802),
                           @"ccce":@(803),
                           @"ddde":@(804),
                           @"aaaee":@(801),
                           @"bbbee":@(802),
                           @"cccee":@(803),
                           @"dddee":@(804)
                           };
    
    GCSDebugSectionView *layerSetion = [[GCSDebugSectionView alloc]initWithValueInfo:dict section:@"EmitterLayer"];
    [self.scrollView addSubview:layerSetion];
    
    CGFloat layerSetionHeight = [layerSetion calculateHeight];
    layerSetion.frame = CGRectMake(0, 0, self.bounds.size.width, layerSetionHeight);
    
    GCSDebugSectionView *cellSetion = [[GCSDebugSectionView alloc]initWithValueInfo:dict section:@"EmitterCell"];
    [self.scrollView addSubview:cellSetion];
    
    CGFloat cellSectionHeight = [cellSetion calculateHeight];
    cellSetion.frame = CGRectMake(0, layerSetionHeight, width, cellSectionHeight);
    
    y = layerSetionHeight + cellSectionHeight;
    self.scrollView.contentSize = CGSizeMake(width, y);
}


@end
