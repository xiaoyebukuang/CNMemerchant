


//
//  OrderDetailHeaderView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/18.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "OrderDetailHeaderView.h"

@interface OrderDetailHeaderView()

@property (nonatomic, strong) UIImageView *logoImageV;

@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, strong) UILabel *stateDesLabel;

@property (nonatomic, strong) UIButton *reloadBtn;



@end

@implementation OrderDetailHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor color_FFFFFF];
    
    [self addSubview:self.reloadBtn];
    [self.reloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).mas_offset(-Normal_Spcae);
        make.top.equalTo(self).mas_offset(Normal_Spcae);
    }];
    
    [self addSubview:self.logoImageV];
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).mas_offset(25);
    }];
    
    [self addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.logoImageV.mas_bottom).mas_offset(20);
    }];
    
    [self addSubview:self.stateDesLabel];
    [self.stateDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.stateLabel.mas_bottom).mas_offset(15);
        make.bottom.equalTo(self).mas_offset(-25);
    }];
}
- (void)reloadViewWithModel:(OrderModel *)orderModel {
    self.logoImageV.image = [UIImage imageNamed:orderModel.imageName];
    self.stateLabel.text = orderModel.stateDetailName;
    self.stateDesLabel.text = orderModel.stateDetailDes;
    CGFloat bottom = (orderModel.stateDetailDes.length == 0?-15:-25);
    [self.stateDesLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).mas_offset(bottom);
    }];
    if (orderModel.orderState == OrderStateWaitPay) {
        self.reloadBtn.hidden = NO;
    } else {
        self.reloadBtn.hidden = YES;
    }
}
- (void)reloadBtnEvent {
    if ([self.delegate respondsToSelector:@selector(needToReloadView)]) {
        [self.delegate needToReloadView];
    }
}
#pragma mark -- setup
- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc]init];
    }
    return _logoImageV;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_B_21];
        _stateLabel.numberOfLines = 0;
    }
    return _stateLabel;
}
- (UILabel *)stateDesLabel {
    if (!_stateDesLabel) {
        _stateDesLabel = [[UILabel alloc]initWithTextColor:[UIColor color_999999] font:SYSTEM_FONT_11];
    }
    return _stateDesLabel;
}
- (UIButton *)reloadBtn {
    if (!_reloadBtn) {
        _reloadBtn = [UIButton buttonWithImage:@"order_reload"];
        [_reloadBtn addTarget:self action:@selector(reloadBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reloadBtn;
}
@end
