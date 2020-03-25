//
//  LoginHeaderView.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/3.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>


//TODO:类型
typedef NS_ENUM(NSInteger, LoginHeaderType) {
    LoginHeaderLogin,           //登录
    LoginHeaderFirst,           //第一次登录
    LoginHeaderReset,           //重置密码
    LoginHeaderForgetPW,        //忘记密码
};

static const CGFloat login_header_heigth = 155.0f;

NS_ASSUME_NONNULL_BEGIN

@interface LoginHeaderView : UIView

- (void)reloadViewWithLoginHeaderType:(LoginHeaderType)loginHeaderType;

@end

NS_ASSUME_NONNULL_END
