//
//  AppDelegate.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/2.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>

#import "CustomTabBarController.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[XYNetworking shareInstance]reachabilityStatusChange];
    //开启三方键盘关闭设置为NO, 默认值为NO.
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setRootViewControoler];
    return YES;
}
- (void)setRootViewControoler {
    UserModel *userModel = [UserModel sharedInstance];
    if (userModel.loginState) {
        CustomTabBarController *tabBarVC = [[CustomTabBarController alloc]init];
        self.window.rootViewController = tabBarVC;
        [self.window makeKeyAndVisible];
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        CustomNavigationController *loginNC = [[CustomNavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = loginNC;
        [self.window makeKeyAndVisible];
    }
}


@end
