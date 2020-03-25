//
//  LoginFirstViewController.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/4.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BasePlainTableViewController.h"
#import "LoginHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginFirstViewController : BasePlainTableViewController

/** 账号 */
@property (nonatomic, copy) NSString *account;

/** 是否重置密码 */
@property (nonatomic, assign) LoginHeaderType loginHeaderType;

@end

NS_ASSUME_NONNULL_END
