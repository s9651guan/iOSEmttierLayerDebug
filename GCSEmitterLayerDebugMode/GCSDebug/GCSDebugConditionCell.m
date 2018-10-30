//
//  GCSDebugConditionCell.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSDebugConditionCell.h"
#import "Masonry.h"

static const CGFloat kPaddingX = 12;//左间距
@interface GCSDebugConditionCell ()

@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation GCSDebugConditionCell

- (UILabel *)valueLabel {
    if (_valueLabel == nil) {
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.numberOfLines = 1;
        _valueLabel.textColor = [UIColor whiteColor];
    }
    return _valueLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.valueLabel];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, kPaddingX, 0, 0));
    }];
}

- (void)updateWithValue:(NSString *)value seletedStyle:(GCSDebugConditionStyle)style {
    [self.valueLabel setText:value];
    self.seletedStyle = style;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
