//
//  BaseAlertView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseAlertView.h"

/**动画时间*/
#define ANIMATION_DURATION 0.3

@implementation BaseAlertView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.duration = ANIMATION_DURATION;
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
    [self addSubview:self.backControl];
    self.backControl.frame = self.bounds;
    [self addSubview:self.infoView];
    
}
#pragma mark -- event
- (void)backControlEvent:(UIControl *)control {
    
}
#pragma mark -- setup
- (UIControl *)backControl {
    if (!_backControl) {
        _backControl = [[UIControl alloc]init];
        [_backControl addTarget:self action:@selector(backControlEvent:) forControlEvents:UIControlEventTouchUpInside];
        _backControl.backgroundColor = [UIColor color_000000_4];
    }
    return _backControl;
}
- (UIView *)infoView {
    if (!_infoView) {
        _infoView = [[UIView alloc]init];
        _infoView.backgroundColor = [UIColor color_FFFFFF];
        _infoView.layer.masksToBounds = YES;
        _infoView.layer.cornerRadius = 10;
    }
    return _infoView;
}
@end
