

//
//  HomeOrderView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/5.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "HomeOrderView.h"

@interface HomeOrderView()

@property (nonatomic, strong) HomeOrderChildView *chiledView01;
@property (nonatomic, strong) HomeOrderChildView *chiledView02;
@property (nonatomic, strong) HomeOrderChildView *chiledView03;

@property (nonatomic, strong) UIImageView *arrowImageV;

@end

@implementation HomeOrderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
        [self initializationView];
    }
    return self;
}
- (void)setupUI {
    self.backgroundColor = [UIColor color_FFFFFF];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    [self addSubview:self.arrowImageV];
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).mas_offset(-10);
        make.centerY.equalTo(self);
    }];
    CGFloat child_width = (MAIN_SCREEN_WIDTH - 2*Normal_Spcae - 10 - 10)/3.0;
    [self addSubview:self.chiledView01];
    [self.chiledView01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).mas_offset(22);
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        make.width.mas_equalTo(child_width);
    }];
    [self addSubview:self.chiledView02];
    [self.chiledView02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(child_width);
        make.top.width.centerY.equalTo(self.chiledView01);
    }];
    [self addSubview:self.chiledView03];
    [self.chiledView03 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(2*child_width);
        make.top.width.centerY.equalTo(self.chiledView01);
    }];
}
- (void)initializationView {
    self.chiledView01.valueLabel.text = @"--";
    self.chiledView02.valueLabel.text = @"--";
    self.chiledView03.valueLabel.text = @"--";
}
- (void)reloadViewWithDataDic:(NSDictionary *)dataDic {
    NSDictionary *statisBean = dataDic[@"statisBean"];
    if ([statisBean isKindOfClass:[NSDictionary class]]) {
        NSString *allNum = [NSString safe_string:statisBean[@"allNum"]];
        NSString *todayAmount = [NSString safe_string:statisBean[@"todayAmount"]];
        NSString *todayOrderNum = [NSString safe_string:statisBean[@"todayOrderNum"]];
        self.chiledView01.valueLabel.text = todayOrderNum;
        self.chiledView02.valueLabel.attributedText = [NSString getAttWithLeftStr:@"¥" leftFont:SYSTEM_FONT_12 rightStr:todayAmount rightFont:SYSTEM_FONT_B_21];
        self.chiledView03.valueLabel.text = allNum;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(gotoOrderListVC)]) {
        [self.delegate gotoOrderListVC];
    }
}

#pragma mark -- setup
- (UIImageView *)arrowImageV {
    if (!_arrowImageV) {
        _arrowImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_arrow"]];
    }
    return _arrowImageV;
}
- (HomeOrderChildView *)chiledView01 {
    if (!_chiledView01) {
        _chiledView01 = [[HomeOrderChildView alloc]initWithTitle:@"今日订单数"];
        _chiledView01.keyLabel.textColor = [UIColor color_999999];
        _chiledView01.keyLabel.font = SYSTEM_FONT_11;
        _chiledView01.valueLabel.textColor = [UIColor color_333333];
        _chiledView01.valueLabel.font = SYSTEM_FONT_B_21;
    }
    return _chiledView01;
}
- (HomeOrderChildView *)chiledView02 {
    if (!_chiledView02) {
        _chiledView02 = [[HomeOrderChildView alloc]initWithTitle:@"今日金额"];
        _chiledView02.keyLabel.textColor = [UIColor color_999999];
        _chiledView02.keyLabel.font = SYSTEM_FONT_11;
        _chiledView02.valueLabel.textColor = [UIColor color_333333];
        _chiledView02.valueLabel.font = SYSTEM_FONT_B_21;
    }
    return _chiledView02;
}
- (HomeOrderChildView *)chiledView03 {
    if (!_chiledView03) {
        _chiledView03 = [[HomeOrderChildView alloc]initWithTitle:@"总订单数"];
        _chiledView03.keyLabel.textColor = [UIColor color_999999];
        _chiledView03.keyLabel.font = SYSTEM_FONT_11;
        _chiledView03.valueLabel.textColor = [UIColor color_333333];
        _chiledView03.valueLabel.font = SYSTEM_FONT_B_21;
    }
    return _chiledView03;
}
@end

@implementation HomeOrderChildView

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        [self addSubview:self.valueLabel];
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
        }];
        [self addSubview:self.keyLabel];
        [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.centerX.equalTo(self);
        }];
        self.keyLabel.text = title;
    }
    return self;
}
#pragma mark -- seutp
- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_B_21];
    }
    return _valueLabel;
}
- (UILabel *)keyLabel {
    if (!_keyLabel) {
        _keyLabel = [[UILabel alloc]initWithTextColor:[UIColor color_999999] font:SYSTEM_FONT_11];
    }
    return _keyLabel;
}
@end

