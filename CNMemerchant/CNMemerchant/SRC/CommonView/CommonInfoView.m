//
//  CommonInfoView.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "CommonInfoView.h"

/**
 请求信息其他展示页面
 */
@interface CommonInfoView()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *infoImage;

@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) UIButton *infoBtn;

@property (nonatomic, copy) CommonInfoBlock commonInfoBlock;
//info类型
@property (nonatomic, assign) CommonInfoType commonInfoType;

@end

@implementation CommonInfoView

+ (CommonInfoView *)showInfoViewSuperView:(UIView *)superView commonInfoType:(CommonInfoType)type{
    return [self showInfoViewSuperView:superView commonInfoType:type commonInfoBlock:nil];
}
+ (CommonInfoView *)showInfoViewSuperView:(UIView *)superView commonInfoType:(CommonInfoType)type commonInfoBlock:(CommonInfoBlock)commonInfoBlock {
    return [self showInfoViewSuperView:superView commonInfoType:type showMes:nil commonInfoBlock:commonInfoBlock];
}
+ (CommonInfoView *)showInfoViewSuperView:(UIView *)superView commonInfoType:(CommonInfoType)type showMes:(NSString *)showMes {
    return [self showInfoViewSuperView:superView commonInfoType:type showMes:showMes commonInfoBlock:nil];
}
+ (CommonInfoView *)showInfoViewSuperView:(UIView *)superView commonInfoType:(CommonInfoType)type showMes:(NSString *)showMes commonInfoBlock:(CommonInfoBlock)commonInfoBlock {
    CommonInfoView *commonInfoView = [[CommonInfoView alloc]initWithCommonInfoType:type showMes:showMes commonInfoBlock:commonInfoBlock];
    commonInfoView.backgroundColor = [superView backgroundColor];
    [superView addSubview:commonInfoView];
    [commonInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    return commonInfoView;
}

+ (void)removeInfoViewFromSuperView:(UIView *)superView {
    for (UIView *subView in superView.subviews) {
        if ([subView isKindOfClass:[CommonInfoView class]]) {
            [subView removeFromSuperview];
        }
    }
}
- (instancetype)initWithCommonInfoType:(CommonInfoType)type showMes:(NSString *)showMes commonInfoBlock:(CommonInfoBlock)commonInfoBlock {
    self = [super init];
    if (self) {
        [self setupUI];
        self.commonInfoBlock = commonInfoBlock;
        self.commonInfoType = type;
        [self setInfoMesWithMes:showMes];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).mas_offset(100);
        make.width.equalTo(self);
    }];
    
    [self.backView addSubview:self.infoImage];
    [self.infoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.backView);
    }];
    
    [self.backView addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoImage);
        make.top.equalTo(self.infoImage.mas_bottom).mas_offset(10);
    }];
    [self.backView addSubview:self.infoBtn];
    [self.infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.infoLabel.mas_bottom).mas_offset(30);
        make.bottom.equalTo(self.backView);
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.backView.centerY = self.centerY;
}
- (void)setInfoMesWithMes:(NSString *)mes {
    switch (self.commonInfoType) {
        case CommonInfoNetworkNone:
        {
            self.infoLabel.text = @"网络异常";
            self.infoImage.image = [UIImage imageNamed:@"info_network"];
            [self.infoBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        }
            break;
        case CommonInfoHomeNoData:
        {
            self.infoLabel.text = @"今日还没有订单";
            self.infoImage.image = [UIImage imageNamed:@"info_no_data"];
            self.infoBtn.hidden = YES;
        }
            break;
        case CommonInfoHomeAllNoData:
        {
            self.infoLabel.text = @"还没有订单";
            self.infoImage.image = [UIImage imageNamed:@"info_no_data"];
            self.infoBtn.hidden = YES;
        }
            break;
    }
}

#pragma mark -- event
- (void)infoBtnEvent:(UIButton *)sender {
    if (self.commonInfoBlock) {
        self.commonInfoBlock(self);
    }
    if (self.commonInfoType == CommonInfoNetworkNone) {
        [self removeFromSuperview];
    }
}

#pragma mark -- setup

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
    }
    return _backView;
}
- (UIImageView *)infoImage {
    if (!_infoImage) {
        _infoImage = [[UIImageView alloc]init];
    }
    return _infoImage;
}
- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]initWithTextColor:[UIColor color_8B8B8B] font:SYSTEM_FONT_14];
    }
    return _infoLabel;
}
- (UIButton *)infoBtn {
    if (!_infoBtn) {
        _infoBtn = [UIButton buttonWithBGImage:@"info_bottom_btn" title:@"" titleColor:[UIColor color_333333] font:SYSTEM_FONT_15];
        [_infoBtn addTarget:self action:@selector(infoBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _infoBtn;
}


@end
