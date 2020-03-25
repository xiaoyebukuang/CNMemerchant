//
//  UIStateView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/12.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "UIStateView.h"

@interface UIStateView()

@property (nonatomic, strong) UIView *bgView;

@end


@implementation UIStateView
- (instancetype)initWithTitle:(NSString *)title {
    self= [super init];
    if (self) {
        [self setupUI];
        self.titleLabel.text = title;
    }
    return self;
}
//TODO:基类
- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.alphaView];
    [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self);
        make.height.mas_equalTo(44);
    }];
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self.bgView);
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH - 120);
        make.height.mas_equalTo(44);
    }];
    [self.bgView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).mas_offset(Normal_Spcae);
        make.centerY.equalTo(self.bgView);
    }];
    [self.bgView addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).mas_offset(-Normal_Spcae);
        make.centerY.equalTo(self.bgView);
    }];
}
- (void)changeAlphaWithAlpha:(CGFloat)alpha {
    self.alphaView.alpha = alpha;
    if (alpha >= 1) {
        self.titleLabel.textColor = [UIColor color_333333];
    } else {
        self.titleLabel.textColor = [UIColor color_FFFFFF];
    }
}
#pragma mark -- setup
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
    }
    return _bgView;
}
- (UIView *)alphaView {
    if (!_alphaView) {
        _alphaView = [[UIView alloc]init];
        _alphaView.backgroundColor = [UIColor color_FFFFFF];
        _alphaView.alpha = 0;
    }
    return _alphaView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithTextColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_B_18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithTitle:@"" titleColor:[UIColor color_333333] font:SYSTEM_FONT_15];
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _rightBtn;
}
@end
