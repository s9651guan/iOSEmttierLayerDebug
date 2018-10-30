//
//  GCSDebugEntryView.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSDebugEntryView.h"
#import "GCSDebugView.h"

static const CGFloat kDebugEntryWidth = 50;
static const CGFloat kPaddingX = 12;//左间距

@interface GCSDebugEntryView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) GCSDebugView *debugView;

@property (nonatomic, assign) BOOL isShowing;//是否展示调试窗口
@property (nonatomic, assign) CGRect originalFrame;//记录原有Frame

@end

@implementation GCSDebugEntryView

- (GCSDebugView *)debugView {
    if (_debugView == nil) {
        _debugView = [[GCSDebugView alloc]init];
        _debugView.alpha = 0;//初始隐藏
    }
    return _debugView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isShowing = NO;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.f;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.frame = CGRectMake(GCS_SCREENW - kDebugEntryWidth - kPaddingX,
                            GCS_SCREENH - 200,
                            kDebugEntryWidth,
                            kDebugEntryWidth);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.debugView];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    if ([gesture state] == UIGestureRecognizerStateEnded) {
        self.isShowing = !self.isShowing;
    }
}

- (void)setIsShowing:(BOOL)isShowing {
    _isShowing = isShowing;
    if (isShowing) {
        [self show];
    } else {
        [self hidden];
    }
}

- (void)show {
    self.originalFrame = self.frame;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = [UIScreen mainScreen].bounds;
        self.debugView.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }];
}

- (void)hidden {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = self.originalFrame;
        self.debugView.alpha = 0;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }];
}

@end
