//
//  LoginHeaderView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/3.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "LoginHeaderView.h"


@interface LoginHeaderView()

@property (nonatomic, strong) UIImageView *logoImageV;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *desLabel;


@end

@implementation LoginHeaderView


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.logoImageV];
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(30);
        make.top.equalTo(self);
    }];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImageV);
        make.top.equalTo(self.logoImageV.mas_bottom).mas_offset(Normal_Spcae);
    }];
    [self addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logoImageV);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(12);
    }];
}
- (void)reloadViewWithLoginHeaderType:(LoginHeaderType)loginHeaderType {
    switch (loginHeaderType) {
        case LoginHeaderLogin:
        {
            self.logoImageV.image = [UIImage imageNamed:@"login_user"];
            self.titleLabel.text = @"商户端登录";
            self.desLabel.text = @"赶快登录查看吧";
        }
            break;
        case LoginHeaderFirst:
        {
            self.logoImageV.image = [UIImage imageNamed:@"login_user_first"];
            self.titleLabel.text = @"商户端登录";
            self.desLabel.text = @"为了安全，首次登录请重置密码和绑定手机号";
        }
            break;
        case LoginHeaderReset:
        {
            self.logoImageV.image = [UIImage imageNamed:@"login_user_pw"];
            self.titleLabel.text = @"重置密码";
            self.desLabel.text = @"为了安全，请填写信息重置密码";
        }
            break;
        case LoginHeaderForgetPW:
        {
            self.logoImageV.image = [UIImage imageNamed:@"login_user_pw"];
            self.titleLabel.text = @"忘记密码";
            self.desLabel.text = @"请输入新密码";
        }
            break;
        default:
            break;
    }
}
#pragma mark -- setup
- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc]init];
    }
    return _logoImageV;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithTextColor:[UIColor color_000000] font:SYSTEM_FONT_B_24];
    }
    return _titleLabel;
}
- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]initWithTextColor:[UIColor color_666666] font:SYSTEM_FONT_12];
    }
    return _desLabel;
}


@end
