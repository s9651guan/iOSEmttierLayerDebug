//
//  GCSValueWindow.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/30.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSValueWindow.h"
#import "GCSEmitterManager.h"
@interface GCSValueWindow () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) GCSValueView *valueView;

@end

@implementation GCSValueWindow

+ (GCSValueWindow *)showValueWindow:(NSString *)attribute type:(GCSDebugConditionStyle)style {
    GCSValueWindow *valueWindow = [[GCSValueWindow alloc]initWithFrame:[UIScreen mainScreen].bounds attribute:attribute style:style];
    //显示Window
    valueWindow.hidden = NO;
    valueWindow.windowLevel = UIWindowLevelStatusBar + 100;
    [valueWindow.window makeKeyAndVisible];
    return valueWindow;
}

- (instancetype)initWithFrame:(CGRect)frame attribute:(NSString *)attribute style:(GCSDebugConditionStyle)style  {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        self.valueView = [[GCSValueView alloc]initWithAttribute:attribute style:style];
        [self addSubview:self.valueView];
        
        GCS_WS(ws);
        self.valueView.doneCallBack = ^(id value) {
            [ws dismiss];
            if (value != nil) {
                [[GCSEmitterManager sharedManager] updateAttribute:attribute value:value];
            }
        };

        [self show];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"销毁Window");
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    
    GCS_WS(ws);
    UIAlertController *aController = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前内容尚未保存，确定退出？" preferredStyle:UIAlertControllerStyleAlert];
    [aController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ws dismiss];
    }]];
    [aController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.rootViewController = nil;
    }]];
    
    
    if (self.rootViewController == nil) {
        self.rootViewController = [UIViewController new];
    }
    [self.rootViewController presentViewController:aController animated:YES completion:^{
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[GCSValueWindow class]]) {
        return YES;
    }
    return NO;
}

- (void)show {
    [self animationType:YES];
}

- (void)dismiss {
    [self animationType:NO];
}

- (void)animationType:(BOOL)isShow {
    CGFloat height = [self.valueView calculateHeight];
    if (isShow) {
        self.alpha = 0;
        self.valueView.frame = CGRectMake(0, GCS_SCREENH, GCS_SCREENW, height);
        [UIView animateWithDuration:0.3 animations:^{
            self.valueView.frame = CGRectMake(0, GCS_SCREENH - height, GCS_SCREENW, height);
            self.alpha = 1;
        }];
    } else {
        self.alpha = 1;
        self.valueView.frame = CGRectMake(0, GCS_SCREENH - height, GCS_SCREENW, height);
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
            self.valueView.frame = CGRectMake(0, GCS_SCREENH, GCS_SCREENW, height);
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }
}

@end
