//
//  MBProgressHUD+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/5/2.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MBProgressHUD+Helper.h"
#import "FLAnimatedImage.h"
typedef NS_ENUM(NSInteger, ProgressHUDType) {
    ProgressHUDTypeLoading,
    ProgressHUDTypeError,
    ProgressHUDTypeSuccess
};

@implementation MBProgressHUD (Helper)
#pragma mark 菊花加载
+ (void)showWindow {
    [self showToView:nil];
}
+ (void)showMessage:(NSString *)message {
    [self showMessage:message ToView:nil];
}
+ (void)showToView:(UIView *)view {
    [self showMessage:nil ToView:view];
}
+ (void)showMessage:(NSString *)message ToView:(UIView *)view {
    [self showMessage:message ToView:view HUDType:ProgressHUDTypeLoading completeBlcok:nil];
}
#pragma mark -- 显示错误信息
+ (void)showError:(NSString *)error{
    [self showError:error ToView:nil];
}
+ (void)showError:(NSString *)error completeBlcok:(MBProgressHUDCompletionBlock)completionBlock {
    [self showError:error ToView:nil completeBlcok:completionBlock];
}
+ (void)showError:(NSString *)error ToView:(UIView *)view {
    [self showError:error ToView:view completeBlcok:nil];
}
+ (void)showError:(NSString *)error ToView:(UIView *)view completeBlcok:(MBProgressHUDCompletionBlock)completionBlock {
    [self hideHUDForView:view];
    [self showMessage:error ToView:view HUDType:ProgressHUDTypeError completeBlcok:completionBlock];
}
#pragma mark -- 显示正确信息
+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success ToView:nil];
}
+ (void)showSuccess:(NSString *)success completeBlcok:(MBProgressHUDCompletionBlock)completionBlock {
    [self showSuccess:success ToView:nil completeBlcok:completionBlock];
}
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view{
    [self showSuccess:success ToView:view completeBlcok:nil];
}
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view completeBlcok:(MBProgressHUDCompletionBlock)completionBlock {
    [self hideHUDForView:view];
    [self showMessage:success ToView:view HUDType:ProgressHUDTypeSuccess completeBlcok:completionBlock];
}
#pragma mark -- 构造
+ (void)showMessage:(NSString *)message ToView:(UIView *)view HUDType:(ProgressHUDType)HUDType completeBlcok:(MBProgressHUDCompletionBlock)completionBlock{
    if (view == nil) {
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.numberOfLines = 0;
    switch (HUDType) {
        case ProgressHUDTypeLoading:
        {
            FLAnimatedImageView *loadImageV = [[FLAnimatedImageView alloc]init];
            hud.customView = loadImageV;
            hud.label.font = SYSTEM_FONT_13;
            hud.label.text = @"加载中请稍后";
            hud.mode = MBProgressHUDModeCustomView;
            FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"loading" ofType:@"gif"]]];
            loadImageV.animatedImage = image;
            hud.margin = 30;
            [loadImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(hud.bezelView).mas_offset(10);
                make.width.mas_equalTo(55);
                make.height.mas_equalTo(70);
            }];
        }
            break;
        case ProgressHUDTypeError:
        {
            CGFloat delay = [self getMessageAfterDelayWithMessage:message];
            hud.mode = MBProgressHUDModeCustomView;
            [hud hideAnimated:YES afterDelay:delay];
            hud.label.font = SYSTEM_FONT_15;
        }
            break;
        case ProgressHUDTypeSuccess:
        {
            CGFloat delay = [self getMessageAfterDelayWithMessage:message];
            hud.mode = MBProgressHUDModeCustomView;
            [hud hideAnimated:YES afterDelay:delay];
            hud.label.font = SYSTEM_FONT_15;
        }
            break;
    }
    if (completionBlock) {
        hud.completionBlock = completionBlock;
    }
    if (message) {
        hud.label.text = message;
    }
    hud.bezelView.color = [UIColor blackColor];
    hud.bezelView.alpha = 0.7;
    hud.contentColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud layoutIfNeeded];
    hud.offset = CGPointMake(0, -hud.bezelView.height/2);
}
+ (CGFloat)getMessageAfterDelayWithMessage:(NSString *)message {
    NSInteger ten_number = message.length/10;
    NSInteger bit_number = message.length%10;
    return ten_number + (bit_number == 0 ? 0 : 1);
}
#pragma mark -- 消失
+ (void)hideHUD{
    [self hideHUDForView:nil];
}
+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) {
        view = (UIView*)[UIApplication sharedApplication].delegate.window;
    }
    [self hideHUDForView:view animated:YES];
}

@end
