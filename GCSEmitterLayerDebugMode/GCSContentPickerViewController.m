//
//  GCSContentPickerViewController.m
//  GCSEmitterLayerDebugMode
//
//  Created by 宋冠辰 on 2018/10/28.
//  Copyright © 2018年 宋冠辰. All rights reserved.
//

#import "GCSContentPickerViewController.h"
#import "GCSEmitterManager.h"
static const CGFloat kContentCellHeight = 60;//cell高度
static const CGFloat kPaddingX = 12;//左间距

static const CGFloat kNameLabelTag = 10086;//图片名Label
static const CGFloat kDetailBtnTag = 18806;//详情Button
static const CGFloat kDetailImageTag = 19908;//详情ImageView

@interface GCSContentPickerViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *maskView;//详情蒙层

@property (nonatomic, copy) NSArray *dataList;//图片数组
@property (nonatomic, strong) NSMutableArray *selectedList;//选中数组

@end

@implementation GCSContentPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupViews];
}

#pragma mark - Private

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    UIBarButtonItem *finishBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.rightBarButtonItem = finishBtn;
    
    self.selectedList = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setEditing:YES animated:NO];
    [self.view addSubview:self.tableView];
    
    self.maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.view addSubview:self.maskView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMaskView:)];
    [self.maskView addGestureRecognizer:tap];
    
    UIImageView *detailImageView = [[UIImageView alloc]init];
    detailImageView.tag = kDetailImageTag;
    [self.maskView addSubview:detailImageView];
}

- (void)initData {
    NSArray *typeArray = @[@"PNG", @"jpg", @"png", @"JPG", @"JPEG", @"jpeg"];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSString *type in typeArray) {
        NSArray *images = [[NSBundle mainBundle] pathsForResourcesOfType:type inDirectory:nil];
        [imageArray addObjectsFromArray:images];
    }
    NSMutableArray *nameArray = [NSMutableArray array];
    for (NSString *imageStr in imageArray) {
        [nameArray addObject:imageStr.lastPathComponent];
    }
    
    self.dataList = nameArray;
}

#pragma mark - Action

- (void)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done:(UIBarButtonItem *)sender {
    [GCSEmitterManager sharedManager].emitterCellNames = self.selectedList;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete |UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.dataList[indexPath.row];
    if (![self.selectedList containsObject:name]) {
        [self.selectedList addObject:name];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.dataList[indexPath.row];
    if ([self.selectedList containsObject:name]) {
        [self.selectedList removeObject:name];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kContentCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"emitterimagecell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kPaddingX, 0, GCS_SCREENW - 50, kContentCellHeight)];
        nameLabel.tag = kNameLabelTag;
        [cell.contentView addSubview:nameLabel];
        
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [detailButton addTarget:self action:@selector(clickDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
        detailButton.layer.cornerRadius = 4.f;
        detailButton.layer.masksToBounds = YES;
        detailButton.backgroundColor = [UIColor darkGrayColor];
        [detailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [detailButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [detailButton setTitle:@"详情" forState:UIControlStateNormal];
        CGSize size = CGSizeMake(45, 30);
        detailButton.frame = CGRectMake(GCS_SCREENW - kPaddingX - size.width, kContentCellHeight / 2 - size.height / 2, size.width, size.height);
        detailButton.tag = kDetailBtnTag;
        [cell addSubview:detailButton];
    }
    
    NSString *name = self.dataList[indexPath.row];
    UILabel *nameLabel = [cell viewWithTag:kNameLabelTag];
    [nameLabel setText:name];
    if ([[GCSEmitterManager sharedManager].emitterCellNames containsObject:name]) {
        [cell setSelected:YES];
        if (![self.selectedList containsObject:name]) {
            [self.selectedList addObject:name];
        }
    }
    return cell;
}

- (void)clickDetailBtn:(UIButton *)sender {
    //查看图片
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    NSString *imageString = ((UILabel *)[cell viewWithTag:kNameLabelTag]).text;
    UIImage *image = [UIImage imageNamed:imageString];
    
    if (!image) {
        return;
    }
    
    UIImageView *detailImageView = [self.maskView viewWithTag:kDetailImageTag];
    [detailImageView setImage:image];
    CGFloat width = GCS_SCREENW / 2;
    CGFloat height = image.size.height / image.size.width * width;
    detailImageView.frame = CGRectMake(GCS_SCREENW / 2 - width / 2, GCS_SCREENH / 2 - height / 2, width, height);
    
    self.maskView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.5;
    }];
}

- (void)tapMaskView:(UITapGestureRecognizer *)gesture {
    self.maskView.alpha = 0.5;
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
    }];
}


@end
