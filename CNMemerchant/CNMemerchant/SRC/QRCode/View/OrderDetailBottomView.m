
//
//  OrderDetailBottomView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/18.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "OrderDetailBottomView.h"
#import "CommonHeaderTableView.h"

static NSString * const OrderDetailBottomTableViewCellID = @"OrderDetailBottomTableViewCellID";

@interface OrderDetailBottomView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) OrderModel *orderModel;

@property (nonatomic, assign) CGFloat cell_height;

@end

@implementation OrderDetailBottomView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cell_height = 37;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.height.mas_equalTo(self.cell_height*3 + COMMON_CELL_HEIGHT);
        }];
        [self.tableView registerClass:[OrderDetailBottomTableViewCell class] forCellReuseIdentifier:OrderDetailBottomTableViewCellID];
    }
    return self;
}

- (void)reloadViewWithModel:(OrderModel *)orderModel {
    self.orderModel = orderModel;
    [self.tableView reloadData];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
/** 段头高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return COMMON_CELL_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cell_height;
}
/** 段头view */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CommonHeaderTableView *sectionView = [[CommonHeaderTableView alloc]initWithImageName:@"home_list_logo" title:[NSString stringWithFormat:@"订单号：%@",self.orderModel.orderNo]];
    UILabel *priceL = [[UILabel alloc]initWithText:[NSString stringWithFormat:@"¥%@",self.orderModel.amount] textColor:[UIColor color_FF5C33] font:SYSTEM_FONT_B_14];
    [sectionView addSubview:priceL];
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView);
        make.right.equalTo(sectionView).mas_offset(-Normal_Spcae);
    }];
    return sectionView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailBottomTableViewCell *cell = (OrderDetailBottomTableViewCell *)[tableView dequeueReusableCellWithIdentifier: OrderDetailBottomTableViewCellID];
    NSArray *nameArr = @[@"卡号",@"油品",@"加油量"];
    NSArray *contentArr = @[[NSString safe_string:self.orderModel.virtualOilcard],
                            [NSString safe_string:self.orderModel.oilName],
                            [NSString stringWithFormat:@"%@L",self.orderModel.oilLiters]];
    [cell reloadViewWithName:nameArr[indexPath.row] content:contentArr[indexPath.row]];
    return cell;
}
#pragma mark -- setup
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.bounces = NO;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 10;
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

@interface OrderDetailBottomTableViewCell()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end


@implementation OrderDetailBottomTableViewCell
- (void)reloadViewWithName:(NSString *)name content:(NSString *)content {
    self.nameLabel.text = name;
    self.contentLabel.text = content;
}
- (void)setupUI {
    [super setupUI];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).mas_offset(Normal_Spcae);
    }];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-Normal_Spcae);
    }];
}
#pragma mark -- setup
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithTextColor:[UIColor color_666666] font:SYSTEM_FONT_14];
    }
    return _nameLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_14];
    }
    return _contentLabel;
}
@end
