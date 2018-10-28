//
//  ViewController.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "ViewController.h"
#import "GCSNavigationController.h"
#import "GCSContentPickerViewController.h"
#import "GCSDebugEntryView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GCSDebugEntryView *view = [GCSDebugEntryView new];
    [self.view addSubview:view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    GCSNavigationController *navController  = [[GCSNavigationController alloc]initWithRootViewController:[GCSContentPickerViewController new]];
//    [self presentViewController:navController animated:YES completion:nil];
}


@end
