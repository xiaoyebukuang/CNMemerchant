//
//  MineSiteInfoView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "MineSiteInfoView.h"
#import "CommonHeaderTableView.h"
static NSString * const MineSiteInfoTableViewCellID = @"MineSiteInfoTableViewCellID";

@interface MineSiteInfoView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineSiteInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.backgroundColor = [UIColor color_FFFFFF];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo(COMMON_CELL_HEIGHT*5);
    }];
    [self.tableView registerClass:[MineSiteInfoTableViewCell class] forCellReuseIdentifier:MineSiteInfoTableViewCellID];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
/** 段头高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return COMMON_CELL_HEIGHT;
}
/** 段头view */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CommonHeaderTableView *sectionView = [[CommonHeaderTableView alloc]initWithImageName:@"mine_site" title:@"站点信息"];
    return sectionView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineSiteInfoTableViewCell *cell = (MineSiteInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier: MineSiteInfoTableViewCellID];
    UserModel *userModle = [UserModel sharedInstance];
    NSArray *keys = @[@"站点名称",@"营业时间",@"地址",@"联系电话"];
    NSArray *values = @[userModle.stationName,userModle.openingTimeStr,userModle.address,userModle.contactNumber];
    [cell reloadViewWithTitle:keys[indexPath.row] content:values[indexPath.row]];
    return cell;
}
#pragma mark -- setup
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0,*)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        }
    }
    return _tableView;
}

@end

@interface MineSiteInfoTableViewCell()

@property (nonatomic, strong) UILabel *keyLabel;

@property (nonatomic, strong) UILabel *valueLabel;

@property (nonatomic, strong) UILineView *lineView;

@end

@implementation MineSiteInfoTableViewCell

- (void)setupUI {
    [super setupUI];
    [self.contentView addSubview:self.keyLabel];
    [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(Normal_Spcae);
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(COMMON_CELL_HEIGHT);
    }];
    [self.contentView addSubview:self.valueLabel];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.keyLabel);
        make.right.equalTo(self.contentView).mas_offset(-Normal_Spcae);
        make.left.equalTo(self.keyLabel.mas_right);
    }];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)reloadViewWithTitle:(NSString *)title content:(NSString *)content {
    self.keyLabel.text = title;
    self.valueLabel.text = content;
}

#pragma mark -- setup
- (UILabel *)keyLabel {
    if (!_keyLabel) {
        _keyLabel = [[UILabel alloc]initWithTextColor:[UIColor color_666666] font:SYSTEM_FONT_14];
    }
    return _keyLabel;
}
- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_14];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.numberOfLines = 2;
    }
    return _valueLabel;
}
- (UILineView *)lineView {
    if (!_lineView) {
        _lineView = [[UILineView alloc]init];
    }
    return _lineView;
}
@end
