//
//  ViewController.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSViewController.h"
#import "GCSNavigationController.h"
#import "GCSContentPickerViewController.h"
#import "GCSDebugEntryView.h"

#import "GCSEmitterView.h"

@interface GCSViewController ()

@property (nonatomic, strong) GCSEmitterView *emitterView;

@end

@implementation GCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    
    self.emitterView = [[GCSEmitterView alloc]initWithFrame:CGRectMake(0, GCS_STATUS_HEIGHT, GCS_SCREENW, GCS_SCREENH - GCS_STATUS_HEIGHT - 80)];
    [self.view addSubview:self.emitterView];
    
    UIButton *fileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fileBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [fileBtn setBackgroundColor:[UIColor grayColor]];
    [fileBtn addTarget:self action:@selector(file:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fileBtn];
    [fileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshBtn setBackgroundColor:[UIColor grayColor]];
    [refreshBtn addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(self.view);
        make.leading.equalTo(fileBtn.mas_trailing).mas_offset(11);
        make.width.equalTo(fileBtn.mas_width);
        make.height.mas_equalTo(30);
    }];
    
    GCSDebugEntryView *view = [GCSDebugEntryView new];
    [self.view addSubview:view];
}

- (void)file:(UIButton *)sender {
    GCSNavigationController *nav = [[GCSNavigationController alloc]initWithRootViewController:[GCSContentPickerViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)refresh:(UIButton *)sender {
    [self.emitterView updateEmitterLayer];
}

@end
