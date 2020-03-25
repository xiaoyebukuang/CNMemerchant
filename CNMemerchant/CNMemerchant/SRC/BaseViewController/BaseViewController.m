//
//  BaseViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/2.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor color_main];
}
- (void)setLeftNavigationBarWithImageStr:(NSString *)imageStr {
    if (!imageStr) {
        return;
    }
    self.base_leftBtn = [UIButton buttonWithImage:imageStr];
    self.base_leftBtn.frame = CGRectMake(0, 0, 44, 44);
    self.base_leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.base_leftBtn addTarget:self action:@selector(leftNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.base_leftBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}
/** imageStr */
- (void)setRightNavigationBarWithImageStr:(NSString *)imageStr {
    if (!imageStr) {
        return;
    }
    self.base_rightBtn = [UIButton buttonWithImage:imageStr];
    self.base_rightBtn.frame = CGRectMake(0, 0, 44, 44);
    self.base_rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.base_rightBtn addTarget:self action:@selector(rightNavigationBarEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.base_rightBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
#pragma mark -- event
- (void)rightNavigationBarEvent:(UIButton *)sender {
    
}
- (void)leftNavigationBarEvent:(UIButton *)sender {
    
}

@end
