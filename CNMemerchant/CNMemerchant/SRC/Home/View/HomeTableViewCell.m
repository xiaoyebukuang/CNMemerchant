//
//  HomeTableViewCell.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/5.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeOrderView.h"
@interface HomeTableViewCell()

@property (nonatomic, strong) UIView *infoView;
// 上
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) UILabel *orderNoL;
@property (nonatomic, strong) UILabel *orderStateL;

// 中
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) HomeOrderChildView *chiledView01;
@property (nonatomic, strong) HomeOrderChildView *chiledView02;
@property (nonatomic, strong) HomeOrderChildView *chiledView03;

// 下
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *cardNoL;
@property (nonatomic, strong) UILabel *dateL;



@end

@implementation HomeTableViewCell

- (void)setupUI {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(Normal_Spcae);
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH - 2*Normal_Spcae);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).mas_offset(-Normal_Spcae);
        make.height.mas_equalTo(185);
    }];
    [self.infoView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.infoView);
        make.height.mas_equalTo(56);
    }];
    
    [self.infoView addSubview:self.middleView];
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.infoView);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(76);
    }];
    
    [self.infoView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self.infoView);
        make.top.equalTo(self.middleView.mas_bottom);
    }];
}
- (void)reloadViewWithModel:(OrderModel *)orderModel {
    self.orderNoL.text = [NSString stringWithFormat:@"订单号：%@",orderModel.orderNo];
    self.orderStateL.text = orderModel.stateName;
    self.orderStateL.backgroundColor = orderModel.stateColor;
    self.chiledView01.valueLabel.text = orderModel.oilName;
    self.chiledView02.valueLabel.text = [NSString stringWithFormat:@"%@L",orderModel.oilLiters];
    self.chiledView03.valueLabel.text = [NSString stringWithFormat:@"¥%@",orderModel.amount];
    self.cardNoL.text = [NSString stringWithFormat:@"卡号：%@",orderModel.virtualOilcard];
    self.dateL.text = orderModel.createDateStr; 
}
#pragma mark -- setup
- (UIView *)infoView {
    if (!_infoView) {
        _infoView = [[UIView alloc]init];
        _infoView.backgroundColor = [UIColor color_FFFFFF];
        _infoView.layer.masksToBounds = YES;
        _infoView.layer.cornerRadius = 10;
    }
    return _infoView;
}
/** 上 */
- (UIView *)topView {
    if (!_topView) {
        UIView *topV = [[UIView alloc]init];
        [topV addSubview:self.logoImageV];
        [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topV).mas_offset(Normal_Spcae);
            make.centerY.equalTo(topV);
        }];
        [topV addSubview:self.orderNoL];
        [self.orderNoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logoImageV.mas_right).mas_offset(5);
            make.centerY.equalTo(topV);
        }];
        [topV addSubview:self.orderStateL];
        [self.orderStateL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topV).mas_offset(-Normal_Spcae);
            make.centerY.equalTo(topV);
            make.width.mas_equalTo(46);
            make.height.mas_equalTo(16);
        }];
        _topView = topV;
    }
    return _topView;
}
- (UIImageView *)logoImageV {
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_list_logo"]];
    }
    return _logoImageV;
}
- (UILabel *)orderNoL {
    if (!_orderNoL) {
        _orderNoL = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_14];
    }
    return _orderNoL;
}
- (UILabel *)orderStateL {
    if (!_orderStateL) {
        _orderStateL = [[UILabel alloc]initWithTextColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_10];
        _orderStateL.textAlignment = NSTextAlignmentCenter;
        _orderStateL.layer.masksToBounds = YES;
        _orderStateL.layer.cornerRadius = 2;
    }
    return _orderStateL;
}
- (UIView *)middleView {
    if (!_middleView) {
        UIView *middleV = [[UIView alloc]init];
        
        UILineView *lineV01 = [[UILineView alloc]init];
        [middleV addSubview:lineV01];
        [lineV01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.width.equalTo(middleV);
            make.height.mas_equalTo(0.5);
        }];
        UILineView *lineV02 = [[UILineView alloc]init];
        [middleV addSubview:lineV02];
        [lineV02 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.width.equalTo(middleV);
            make.height.mas_equalTo(0.5);
        }];
        CGFloat child_width = (MAIN_SCREEN_WIDTH - 2*Normal_Spcae)/3.0;
        [middleV addSubview:self.chiledView01];
        [self.chiledView01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(middleV).mas_offset(20);
            make.centerY.equalTo(middleV);
            make.left.equalTo(middleV);
            make.width.mas_equalTo(child_width);
        }];
        [middleV addSubview:self.chiledView02];
        [self.chiledView02 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(middleV).mas_offset(child_width);
            make.top.width.centerY.equalTo(self.chiledView01);
        }];
        [middleV addSubview:self.chiledView03];
        [self.chiledView03 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(middleV).mas_offset(2*child_width);
            make.top.width.centerY.equalTo(self.chiledView01);
        }];
        _middleView = middleV;
    }
    return _middleView;
}
- (HomeOrderChildView *)chiledView01 {
    if (!_chiledView01) {
        _chiledView01 = [[HomeOrderChildView alloc]initWithTitle:@"油卡"];
        _chiledView01.keyLabel.textColor = [UIColor color_666666];
        _chiledView01.keyLabel.font = SYSTEM_FONT_12;
        _chiledView01.valueLabel.textColor = [UIColor color_333333];
        _chiledView01.valueLabel.font = SYSTEM_FONT_B_14;
    }
    return _chiledView01;
}
- (HomeOrderChildView *)chiledView02 {
    if (!_chiledView02) {
        _chiledView02 = [[HomeOrderChildView alloc]initWithTitle:@"加油量"];
        _chiledView02.keyLabel.textColor = [UIColor color_666666];
        _chiledView02.keyLabel.font = SYSTEM_FONT_12;
        _chiledView02.valueLabel.textColor = [UIColor color_333333];
        _chiledView02.valueLabel.font = SYSTEM_FONT_B_14;
    }
    return _chiledView02;
}
- (HomeOrderChildView *)chiledView03 {
    if (!_chiledView03) {
        _chiledView03 = [[HomeOrderChildView alloc]initWithTitle:@"消费金额"];
        _chiledView03.keyLabel.textColor = [UIColor color_666666];
        _chiledView03.keyLabel.font = SYSTEM_FONT_12;
        _chiledView03.valueLabel.textColor = [UIColor color_FD7E2D];
        _chiledView03.valueLabel.font = SYSTEM_FONT_B_14;
    }
    return _chiledView03;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        UIView *bottomV = [[UIView alloc]init];
        [bottomV addSubview:self.cardNoL];
        [self.cardNoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomV).mas_offset(Normal_Spcae);
            make.centerY.equalTo(bottomV);
        }];
        [bottomV addSubview:self.dateL];
        [self.dateL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bottomV).mas_offset(-Normal_Spcae);
            make.centerY.equalTo(bottomV);
        }];
        _bottomView = bottomV;
    }
    return _bottomView;
}
- (UILabel *)cardNoL {
    if (!_cardNoL) {
        _cardNoL = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_12];
    }
    return _cardNoL;
}
- (UILabel *)dateL {
    if (!_dateL) {
        _dateL = [[UILabel alloc]initWithTextColor:[UIColor color_999999] font:SYSTEM_FONT_12];
    }
    return _dateL;
}
@end
