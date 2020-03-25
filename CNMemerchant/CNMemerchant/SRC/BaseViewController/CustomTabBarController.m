//
//  CustomTabBarController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/3.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "CustomTabBarController.h"
#import "BaseViewController.h"
#import "CustomNavigationController.h"
#import "BaseTabBar.h"
@interface CustomTabBarController ()<UITabBarControllerDelegate>

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.view.backgroundColor = [UIColor color_FFFFFF];
    [self setupViewControllers];
    [self setBaseTabBarUI];
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *tabbarAppearance = self.tabBar.standardAppearance;
        tabbarAppearance.shadowImage = [UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(self.tabBar.frame.size.width, 0.5)];
        tabbarAppearance.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor] size:self.tabBar.bounds.size];
        tabbarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor color_333333]};
        tabbarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor color_FD7E2D]};
        self.tabBar.standardAppearance = tabbarAppearance;
    } else {
        [self changeLineOfTabbarColor];
    }
}
- (void)changeLineOfTabbarColor {
    CGRect rect = CGRectMake(0.0f, 0.0f, MAIN_SCREEN_WIDTH, 0.5);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:image];
    [self.tabBar setBackgroundImage:[UIImage new]];
}
- (void)setupViewControllers {
    NSArray *controllerName = @[@"HomeViewController",@"QRViewController",@"MineViewController"];
    NSArray *normalImages = @[@"tab_normal_01",@"tab_normal_02",@"tab_normal_03"];
    NSArray *selectImages = @[@"tab_select_01",@"tab_select_02",@"tab_select_03"];
    NSArray *titles = @[@"工作台",@"",@"我的"];
    for (int i = 0; i < controllerName.count; i ++) {
        BaseViewController *viewController = [[NSClassFromString(controllerName[i]) alloc]init];
        viewController.isFirstVC = YES;
        UIImage *normalImage = [UIImage imageNamed:normalImages[i]];
        UIImage *selectImage = [UIImage imageNamed:selectImages[i]];
        normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *title = titles[i];
        viewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:normalImage selectedImage:selectImage];
        viewController.tabBarItem.title = title;
        viewController.navigationItem.title = title;
        if (@available(iOS 13.0, *)) {
        } else {
            [viewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor color_333333],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
            [viewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor color_FD7E2D],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        }
        CustomNavigationController* nav = [[CustomNavigationController alloc]initWithRootViewController:viewController];
        [self addChildViewController:nav];
    }
}
- (void)setBaseTabBarUI {
    BaseTabBar *baseTabBar = [[BaseTabBar alloc]init];
    [baseTabBar.centerTabBarBtn addTarget:self action:@selector(centerTabBarBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self setValue:baseTabBar forKey:@"tabBar"];
}
#pragma mark -- UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}
#pragma mark -- event
- (void)centerTabBarBtnEvent {
    self.selectedIndex = 1;
}


@end
