//
//  BaseMultiViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/3.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"

@interface BaseMultiViewController ()

@end

@implementation BaseMultiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.isFirstVC) {
        [self setLeftNavigationBarWithImageStr:@"nav_btn_back"];
    }
}
- (void)leftNavigationBarEvent:(UIButton *)sender {
    [super leftNavigationBarEvent:sender];
    [XYNetworking cancelAllTask];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
