//
//  CommonHeaderTableView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "CommonHeaderTableView.h"

@interface CommonHeaderTableView()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILineView *lineView;

@end

@implementation CommonHeaderTableView

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title {
    self = [super init];
    if (self) {
        [self addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).mas_offset(Normal_Spcae);
        }];
        [self addSubview:self.titleL];
        [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.imageV.mas_right).mas_offset(5);
        }];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.bottom.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        self.imageV.image = [UIImage imageNamed:imageName];
        self.titleL.text = title;
    }
    return self;
}
#pragma mark -- setup
- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc]init];
    }
    return _imageV;
}
- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_B_14];
    }
    return _titleL;
}
- (UILineView *)lineView {
    if (!_lineView) {
        _lineView = [[UILineView alloc]init];
    }
    return _lineView;
}

@end
