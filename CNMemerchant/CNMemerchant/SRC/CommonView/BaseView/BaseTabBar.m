//
//  BaseTabBar.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/3.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseTabBar.h"

@implementation BaseTabBar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor color_FFFFFF];
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.centerTabBarBtn];
    [self.centerTabBarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).mas_offset(-IPHONEX_BOTTOW_HEIGHT);
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self bringSubviewToFront:self.centerTabBarBtn];
}
#pragma mark -- setup
- (UIButton *)centerTabBarBtn {
    if (!_centerTabBarBtn) {
        _centerTabBarBtn = [UIButton buttonWithImage:@"tab_middle"];
    }
    return _centerTabBarBtn;
}

@end
