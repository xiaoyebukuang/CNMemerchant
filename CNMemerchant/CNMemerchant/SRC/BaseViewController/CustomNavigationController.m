//
//  CustomNavigationController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/3.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "CustomNavigationController.h"
#import "BaseViewController.h"
@interface CustomNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

/** 是否隐藏状态栏 */
@property (nonatomic, assign) BOOL hiddenStatusBar;

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
    self.hiddenStatusBar = NO;
    self.navigationBar.translucent = NO;
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName: SYSTEM_FONT_B_17,NSForegroundColorAttributeName: [UIColor color_333333]};
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    NSMutableArray *removeArray = [NSMutableArray array];
    if (self.viewControllers.count > 1) {
        for (int i = 0; i < self.viewControllers.count - 1; i ++) {
            BaseViewController *vc = self.viewControllers[i];
            if (vc.removeWhenPush) {
                [removeArray addObject:vc];
            }
        }
    }
    NSMutableArray *viewC = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewC removeObjectsInArray:removeArray];
    self.viewControllers = viewC;
    return [super popViewControllerAnimated:animated];
}
#pragma mark -- UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /** 需要隐藏导航的的vc */
    NSArray *hidenControllers = @[@"LoginViewController",               //登录页面
                                  @"HomeViewController",                //首页
                                  @"MineViewController",                //我的
                                  @"QRViewController",                  //二维码
                                ];
    if ([hidenControllers containsObject:NSStringFromClass(self.topViewController.class)]) {
        [self setNavigationBarHidden:YES animated:YES];
    } else {
        [self setNavigationBarHidden:NO animated:YES];
    }
}
- (BOOL)prefersStatusBarHidden{
    return self.hiddenStatusBar;
}
@end
