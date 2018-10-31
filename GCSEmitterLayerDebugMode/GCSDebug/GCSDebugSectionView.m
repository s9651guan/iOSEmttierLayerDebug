//
//  GCSDebugSectionView.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSDebugSectionView.h"
#import "GCSDebugConditionCell.h"
#import "GCSValueWindow.h"

static const CGFloat kPaddingX = 12;//左间距
static const CGFloat kCellHeight = 30;//cell高度

@interface GCSDebugSectionView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *sectionLabel;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSDictionary *info;//配置字典
@property (nonatomic, copy) NSString *section;

@property (nonatomic, strong) GCSValueWindow *valueWindow;

@end

@implementation GCSDebugSectionView

- (UILabel *)sectionLabel {
    if (_sectionLabel == nil) {
        _sectionLabel = [[UILabel alloc]init];
        _sectionLabel.numberOfLines = 1;
    }
    return _sectionLabel;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (instancetype)initWithValueInfo:(NSDictionary<NSString*, NSValue*> *)info  section:(NSString *)section {
    self = [super init];
    if (self) {
        self.section = section;
        self.info = info;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.sectionLabel setText:self.section];
    [self addSubview:self.sectionLabel];
    [self.sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(kPaddingX);
        make.top.mas_equalTo(kPaddingX);
    }];
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionLabel.mas_bottom);
        make.leading.bottom.trailing.equalTo(self);
    }];
}

- (CGFloat)calculateHeight {
    CGFloat y = 0;
    y += kPaddingX;
    CGFloat titleHeight = [self.sectionLabel intrinsicContentSize].height;
    y += titleHeight;
    y += self.info.count * kCellHeight;
    return y;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.info.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"conditioncell";
    GCSDebugConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GCSDebugConditionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSArray *values = self.info.allKeys;
    NSString *value = values[indexPath.row];
    [cell updateWithValue:value seletedStyle:[self.info[value] integerValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *values = self.info.allKeys;
    NSString *value = values[indexPath.row];
    GCSDebugConditionStyle style = [self.info[value] integerValue];

    self.valueWindow = [GCSValueWindow showValueWindow:value type:style dismissCompletionHandler:^{
        self.valueWindow = nil;
    }];
}

@end
