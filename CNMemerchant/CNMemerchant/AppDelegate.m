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
#import "GuidePageViewController.h"
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
    //保存的版本号
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] stringForKey:USERDEFAULTS_APP_VERSION];
    //当前的版本号
    NSString *currentVersion = [UIDevice getAppVersion];
    if (![oldVersion isEqualToString:currentVersion]) {
        GuidePageViewController *guidePVC = [[GuidePageViewController alloc]init];
        self.window.rootViewController = guidePVC;
        [self.window makeKeyAndVisible];
    } else {
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
}


@end
