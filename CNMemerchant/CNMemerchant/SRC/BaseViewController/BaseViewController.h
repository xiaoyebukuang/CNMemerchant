//
//  BaseViewController.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/2.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

/** 默认为NO */
@property (nonatomic, assign) BOOL isFirstVC;
/** 左侧按钮 */
@property (nonatomic, strong) UIButton *base_leftBtn;
/** 右侧按钮 */
@property (nonatomic, strong) UIButton *base_rightBtn;
/** 当push到其他页面时是否移除 */
@property (nonatomic, assign) BOOL removeWhenPush;

- (void)setLeftNavigationBarWithImageStr:(NSString *)imageStr;

- (void)setRightNavigationBarWithImageStr:(NSString *)imageStr;

/** event */
- (void)rightNavigationBarEvent:(UIButton *)sender;
- (void)leftNavigationBarEvent:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
