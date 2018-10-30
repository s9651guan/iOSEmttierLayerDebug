//
//  GCSValueView.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/29.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSValueView.h"
#import "GCSAttributedMap.h"

static const CGFloat kPaddingX = 12;//左间距
static const CGFloat kPaddingY = 12;//上间距
static const CGFloat kTextFieldHeight = 20;//输入框高度
static const CGFloat kSpaceY = 4;//控件间距

static NSString * const kChooseTypeKey = @"chooseTypeKey";

@interface GCSValueView () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, assign) GCSValueViewStyle style;//属性类型

@property (nonatomic, strong) UILabel *attLabel;//属性名Label
@property (nonatomic, copy) NSString *att;//属性名

@property (nonatomic, strong) UIView *contentView;//内容View
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) NSMutableDictionary *valueInfo;//值字典
@property (nonatomic, copy) NSArray *typesList;
@end

@implementation GCSValueView

- (UILabel *)attLabel {
    if (_attLabel == nil) {
        _attLabel = [UILabel new];
        _attLabel.text = self.att;
        _attLabel.textAlignment = NSTextAlignmentCenter;
        _attLabel.textColor = [UIColor colorWithHexString:@"#4B4B4B"];
        _attLabel.numberOfLines = 1.f;
    }
    return _attLabel;
}

- (UIButton *)finishBtn {
    if (_finishBtn == nil) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_finishBtn addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        [_finishBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        _finishBtn.layer.masksToBounds = YES;
        _finishBtn.layer.cornerRadius = 4.f;
    }
    return _finishBtn;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (instancetype)initWithAttribute:(NSString *)att style:(GCSValueViewStyle)style {
    self = [super init];
    if (self) {
        self.att = att;
        self.style = style;
        self.valueInfo = [NSMutableDictionary dictionary];
        self.typesList = [GCSAttributedMap typesOfAttribute:self.att];
        self.backgroundColor = [UIColor grayColor];
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.attLabel];
    CGFloat attHeight = [self.attLabel intrinsicContentSize].height;
    self.attLabel.frame = CGRectMake(kPaddingX, kPaddingY, GCS_SCREENW - 2 * kPaddingX, attHeight);
    
    [self addSubview:self.contentView];
    [self updateContentView];
    
    [self addSubview:self.finishBtn];
    CGSize buttonSize = CGSizeMake(45, 30);
    self.finishBtn.frame = CGRectMake(GCS_SCREENW / 2 - buttonSize.width / 2, CGRectGetMaxY(self.contentView.frame) + kPaddingY, buttonSize.width, buttonSize.height);
    
    self.frame = CGRectMake(0, 100, GCS_SCREENW, CGRectGetMaxY(self.finishBtn.frame) + kPaddingY);
}

- (void)done:(UIButton *)sender {
    id value;
    if (self.style == GCSValueViewStyleChooseType) {
        value = self.valueInfo[kChooseTypeKey];
    } else if (self.style == GCSValueViewStyleWriteFloat ||
               self.style == GCSValueViewStyleWriteString) {
        value = self.valueInfo[@"输入值"];
    } else if (self.style == GCSValueViewStyleWritePoint) {
        value = [NSValue valueWithCGPoint:CGPointMake([self.valueInfo[@"x"] floatValue],
                                                      [self.valueInfo[@"y"] floatValue])];
    } else if (self.style == GCSValueViewStyleWriteSize) {
        value = [NSValue valueWithCGPoint:CGPointMake([self.valueInfo[@"width"] floatValue],
                                                      [self.valueInfo[@"height"] floatValue])];
    } else if (self.style == GCSValueViewStyleWriteRect) {
       value = [NSValue valueWithCGRect:CGRectMake([self.valueInfo[@"x"] floatValue],
                                                   [self.valueInfo[@"y"] floatValue],
                                                   [self.valueInfo[@"width"] floatValue],
                                                   [self.valueInfo[@"height"] floatValue])];
    }
    
    if (self.doneCallBack) {
        self.doneCallBack(value);
    }
}

#pragma mark - Private

- (void)updateContentView {
    CGFloat height = 0;
    if (self.style == GCSValueViewStyleChooseType) {
        UIPickerView *pickerView = [self pickerViewForChooseTypeStyle];
        [self.contentView addSubview:pickerView];
        [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        height += 80;
    } else if (self.style == GCSValueViewStyleWriteFloat ||
               self.style == GCSValueViewStyleWriteString) {
        UITextField *textField = [self textFieldWithName:@"输入值"];
        [self.contentView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        height += kTextFieldHeight;
    } else if (self.style == GCSValueViewStyleWritePoint) {
        NSArray *nameArr = @[@"x", @"y"];
        [self view:self.contentView setupTextFieldsWithArray:nameArr];
        height += kTextFieldHeight;
    } else if (self.style == GCSValueViewStyleWriteSize) {
        NSArray *nameArr = @[@"width", @"height"];
        [self view:self.contentView setupTextFieldsWithArray:nameArr];
        height += kTextFieldHeight;
    } else if (self.style == GCSValueViewStyleWriteRect) {
        NSArray *nameArr = @[@"x", @"y", @"width", @"height"];
        [self view:self.contentView setupTextFieldsWithArray:nameArr];
        height += kTextFieldHeight * 2 + kSpaceY;
    }
    
    self.contentView.frame = CGRectMake(kPaddingX,
                                        CGRectGetMaxY(self.attLabel.frame) + kPaddingY,
                                        GCS_SCREENW - kPaddingX * 2,
                                        height);
    
}

- (void)view:(UIView *)contentView setupTextFieldsWithArray:(NSArray *)nameArr {
    [nameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *textField = [self textFieldWithName:obj];
        [contentView addSubview:textField];
        textField.frame = [self calculateFrame:idx];
    }];
}

- (CGRect)calculateFrame:(NSInteger)idx {
    NSInteger i = idx / 2 + 1;//行
    NSInteger j = idx % 2 + 1;//列
    CGFloat width = (GCS_SCREENW - 3 * kPaddingX) / 2;
    return CGRectMake((kPaddingX + width) * (j - 1),
                                 (kSpaceY + kTextFieldHeight) * (i - 1),
                                 width,
                                 kTextFieldHeight);
}

- (UIPickerView *)pickerViewForChooseTypeStyle {
    UIPickerView *pickerView = [UIPickerView new];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    return pickerView;
}

- (UITextField *)textFieldWithName:(NSString *)name {
    UITextField *textField = [UITextField new];
    textField.placeholder = name;
    [textField setValue:[UIColor colorWithHexString:@"#C1C1C1"] forKeyPath:@"_placeholderLabel.textColor"];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = [UIColor colorWithHexString:@"#4B4B4B"];
    textField.returnKeyType = UIReturnKeyDone;
    textField.borderStyle = UITextBorderStyleLine;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.tintColor = [UIColor colorWithHexString:@"#359df5"];
    [textField addTarget:self action:@selector(valueDidChanged:) forControlEvents:UIControlEventEditingChanged];
    textField.delegate = self;
    if (self.style != GCSValueViewStyleWriteString) {
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    
    return textField;
}

#pragma mark -TextField Delegate

- (void)valueDidChanged:(UITextField *)textField {
    if (!GCS_VerifiedString(textField.text)) {
        return;
        
    }
    [self.valueInfo setObject:textField.text forKey:textField.placeholder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Picker Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.typesList.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 20;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.typesList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *type = self.typesList[row];
    self.valueInfo = [@{kChooseTypeKey : type} mutableCopy];
}

@end
