
//
//  MinePhoneAlertView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "MinePhoneAlertView.h"

@interface MinePhoneAlertView()

@property (nonatomic, strong) UIImageView *logoImageV;

@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UIButton *knowBtn;

@end

@implementation MinePhoneAlertView

+ (void)show {
    MinePhoneAlertView *alertView = [[MinePhoneAlertView alloc]init];
    [kAppDelegateWindow addSubview:alertView];
}
- (void)setupUI {
    [super setupUI];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.left.equalTo(self).mas_offset(50);
    }];
    [self.infoView addSubview:self.logoImageV];
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoView);
        make.top.equalTo(self.infoView).mas_offset(25);
        make.height.width.mas_equalTo(70);
    }];
    [self.infoView addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoView);
        make.left.equalTo(self.infoView).mas_offset(25);
        make.top.equalTo(self.logoImageV.mas_bottom).mas_offset(10);
    }];
    [self.infoView addSubview:self.knowBtn];
    [self.knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoView);
        make.left.equalTo(self.infoView).mas_offset(60);
        make.top.equalTo(self.desLabel.mas_bottom).mas_offset(25);
        make.height.mas_equalTo(35);
        make.bottom.equalTo(self.infoView).mas_offset(-25);
    }];
    
}
#pragma mark -- event
- (void)knowBtnEvent {
    [self removeFromSuperview];
}
- (void)backControlEvent:(UIControl *)control {
    [self removeFromSuperview];
}
#pragma mark -- setup
- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_phone_big_exp"]];
    }
    return _logoImageV;
}
- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]initWithText:@"手机号为绑定账号手机号，如需修改请联系您的BD" textColor:[UIColor color_666666] font:SYSTEM_FONT_14];
        _desLabel.numberOfLines = 0;
        _desLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _desLabel;
}
- (UIButton *)knowBtn {
    if (!_knowBtn) {
        _knowBtn = [UIButton buttonWithTitle:@"知道了" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_16];
        [_knowBtn addTarget:self action:@selector(knowBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        _knowBtn.backgroundColor = [UIColor color_FD7E2D];
        _knowBtn.layer.masksToBounds = YES;
        _knowBtn.layer.cornerRadius = 35.0/2.0;
    }
    return _knowBtn;
}

@end
