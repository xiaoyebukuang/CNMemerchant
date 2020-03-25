//
//  CommonButtonView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/4.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "CommonButtonView.h"

@implementation CommonButtonView

- (instancetype)initWithTitle:(NSString *)title callBack:(CommonButtonViewBlock)callBack {
    self = [super init];
    if (self) {
        self.callBack = callBack;
        UIButton *btn = [UIButton buttonWithTitle:title titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_18];
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor color_FD7E2D];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = common_button_height/2.0f;
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(30);
            make.centerX.centerY.equalTo(self);
            make.height.mas_equalTo(common_button_height);
        }];
    }
    return self;
}
- (void)btnEvent:(UIButton *)sender {
    if (self.callBack) {
        self.callBack();
    }
}
- (instancetype)initBottomWithTitle:(NSString *)title callBack:(CommonButtonViewBlock)callBack {
    self = [super init];
    if (self) {
        self.callBack = callBack;
        UIButton *btn = [UIButton buttonWithTitle:title titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_18];
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor color_FD7E2D];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
    
    
}

@end
