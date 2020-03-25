//
//  MineHeaderView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "MineHeaderView.h"
#import "UIRadianLayerView.h"
#import "MinePhoneAlertView.h"
@interface MineHeaderView()

@property (nonatomic, strong) UIRadianLayerView *radianLayerView;

@property (nonatomic, strong) UILabel *userNameL;

@property (nonatomic, strong) UILabel *phoneTelL;

@property (nonatomic, strong) UIButton *expBtn;

@property (nonatomic, strong) UIImageView *headerLogo;



@end

@implementation MineHeaderView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.backgroundColor = [UIColor color_main];
    [self addSubview:self.radianLayerView];
    [self.radianLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo(150 + NAV_BAR_HEIGHT);
    }];
    [self addSubview:self.userNameL];
    [self.userNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(Normal_Spcae);
        make.top.equalTo(self).mas_offset(NAV_BAR_HEIGHT + Normal_Spcae);
    }];
    [self addSubview:self.phoneTelL];
    [self.phoneTelL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameL);
        make.top.equalTo(self.userNameL.mas_bottom).mas_offset(12);
    }];
    [self addSubview:self.expBtn];
    [self.expBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTelL.mas_right);
        make.centerY.equalTo(self.phoneTelL);
        make.height.width.mas_equalTo(40);
    }];
    [self addSubview:self.headerLogo];
    self.headerLogo.backgroundColor = [UIColor color_random];
    [self.headerLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(NAV_BAR_HEIGHT + 10);
        make.height.width.mas_equalTo(60);
        make.right.equalTo(self).mas_offset(-20);
    }];
    self.userNameL.text = [UserModel sharedInstance].account;
    self.phoneTelL.text = [UserModel sharedInstance].telephone;
    [self.headerLogo sd_setImageWithURL:[NSURL URLWithString:[UserModel sharedInstance].stationImg]];
}
- (void)expBtnEvent {
    [MinePhoneAlertView show];
}
#pragma mark -- setup
- (UIRadianLayerView *)radianLayerView {
    if (!_radianLayerView) {
        _radianLayerView = [[UIRadianLayerView alloc]initWithHieght:150 + NAV_BAR_HEIGHT];
    }
    return _radianLayerView;
}
- (UILabel *)userNameL {
    if (!_userNameL) {
        _userNameL = [[UILabel alloc]initWithTextColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_B_21];
    }
    return _userNameL;
}
- (UILabel *)phoneTelL {
    if (!_phoneTelL) {
        _phoneTelL = [[UILabel alloc]initWithTextColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_14];
    }
    return _phoneTelL;
}
- (UIButton *)expBtn {
    if (!_expBtn) {
        _expBtn = [UIButton buttonWithImage:@"mine_phone_exp"];
        [_expBtn addTarget:self action:@selector(expBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expBtn;
}
- (UIImageView *)headerLogo {
    if (!_headerLogo) {
        _headerLogo = [[UIImageView alloc]init];
        _headerLogo.layer.masksToBounds = YES;
        _headerLogo.layer.cornerRadius = 30;
    }
    return _headerLogo;
}

@end
