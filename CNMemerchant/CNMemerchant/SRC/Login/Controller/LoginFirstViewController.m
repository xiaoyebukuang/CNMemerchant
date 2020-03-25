//
//  LoginFirstViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/4.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "LoginFirstViewController.h"
#import "LoginTableViewCell.h"

static NSString * const LoginTableViewCellID = @"LoginTableViewCellID";

@interface LoginFirstViewController ()

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) LoginHeaderView *loginHeaderView;

@property (nonatomic, strong) UIView *footerView;

/** 初始密码 */
@property (nonatomic, copy) NSString *initialPassword;
/** 新密码 */
@property (nonatomic, copy) NSString *password;
/** 确认密码 */
@property (nonatomic, copy) NSString *confirmPassword;
/** 手机号 */
@property (nonatomic, copy) NSString *phoneNo;
/** 验证码 */
@property (nonatomic, copy) NSString *verifyCode;

@end

@implementation LoginFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    if (self.account.length == 0) {
        self.account = [UserModel sharedInstance].account;
    }
}
- (void)setupUI {
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor color_FFFFFF];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self.tableView registerClass:[LoginTableViewCell class] forCellReuseIdentifier:LoginTableViewCellID];
}
#pragma mark -- request
- (void)virtualBusiness_accountResetPassword {
    NSString *errorStr;
    if (self.initialPassword.length == 0) {
        errorStr = @"请输入原始密码";
    } else if (self.password.length == 0) {
        errorStr = @"请输入新密码";
    } else if (self.confirmPassword.length == 0) {
        errorStr = @"请输入确认密码";
    } else if (self.phoneNo.length == 0) {
        errorStr = @"请输入手机号";
    } else if (self.verifyCode.length == 0) {
        errorStr = @"请输入验证码";
    } else if (![self.password isEqualToString:self.confirmPassword]) {
        errorStr = @"新密码和确认密码不一致";
    }
    if (errorStr.length > 0) {
        [MBProgressHUD showError:errorStr ToView:self.view];
        return;
    }
    [self.view endEditing:YES];
    NSDictionary *parameters = @{@"account":self.account,
                                 @"initialPassword":self.initialPassword,
                                 @"newPassword":self.password,
                                 @"confirmPassword":self.confirmPassword,
                                 @"phoneNo":self.phoneNo,
                                 @"verifyCode":self.verifyCode};
    [RequestMacros virtualBusiness_accountResetPasswordView:self.view parameters:parameters success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        if (self.loginHeaderType == LoginHeaderReset) {
            //重置密码
            [[UserModel sharedInstance] signOut];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginTableViewCell *cell = (LoginTableViewCell *)[tableView dequeueReusableCellWithIdentifier: LoginTableViewCellID];
    NSArray *contents = @[[NSString safe_string:self.initialPassword],
                          [NSString safe_string:self.password],
                          [NSString safe_string:self.confirmPassword],
                          [NSString safe_string:self.phoneNo],
                          [NSString safe_string:self.verifyCode]];
    NSArray *types = @[(self.loginHeaderType == LoginHeaderFirst?@(LoginTextFieldOriginalPW):@(LoginTextFieldOldPW)),
                       @(LoginTextFieldNewPW),
                       @(LoginTextFieldAgainNewPW),
                       @(LoginTextFieldTel),
                       @(LoginTextFieldCode)];
    WeakSelf;
    cell.cachePhoneNo = self.phoneNo;
    [cell reloadViewWithLoginTextFieldType:[NSString safe_string:types[indexPath.row]].intValue content:contents[indexPath.row] loginTextFieldEditBlock:^(NSString * _Nullable title) {
        if (indexPath.row == 0) {
            weakSelf.initialPassword = title;
        } else if (indexPath.row == 1) {
            weakSelf.password = title;
        } else if (indexPath.row == 2) {
            weakSelf.confirmPassword = title;
        } else if (indexPath.row == 3) {
            weakSelf.phoneNo = title;
            for (LoginTableViewCell *existCell in weakSelf.tableView.visibleCells) {
                existCell.cachePhoneNo = title;
            }
        } else {
            weakSelf.verifyCode = title;
        }
    }];
    return cell;
}
#pragma mark -- setup
- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, login_header_heigth)];
        [headerV addSubview:self.loginHeaderView];
        [self.loginHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(headerV);
            make.top.equalTo(headerV);
            make.height.mas_equalTo(login_header_heigth);
        }];
        _headerView = headerV;
    }
    return _headerView;
}
- (LoginHeaderView *)loginHeaderView {
    if (!_loginHeaderView) {
        _loginHeaderView = [[LoginHeaderView alloc]init];
        [_loginHeaderView reloadViewWithLoginHeaderType:self.loginHeaderType];
    }
    return _loginHeaderView;
}
- (UIView *)footerView {
    if (!_footerView) {
        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 100)];
        WeakSelf;
        CommonButtonView *bottonView = [[CommonButtonView alloc]initWithTitle:@"确认" callBack:^{
            [weakSelf virtualBusiness_accountResetPassword];
        }];
        [footerV addSubview:bottonView];
        [bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(footerV);
            make.top.equalTo(footerV).mas_offset(45);
            make.height.mas_equalTo(common_button_height);
        }];
        _footerView = footerV;
    }
    return _footerView;
}
@end
