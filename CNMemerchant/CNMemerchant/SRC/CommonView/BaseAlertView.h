//
//  BaseAlertView.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseAlertView : UIView

/** 背景 */
@property (nonatomic, strong) UIControl *backControl;
/** 动画时间 */
@property (nonatomic, assign) CGFloat duration;
/** 主view */
@property (nonatomic, strong) UIView *infoView;

/** 初始化UI */
- (void)setupUI;
/** 背景点击事件 */
- (void)backControlEvent:(UIControl *)control;

@end

NS_ASSUME_NONNULL_END
