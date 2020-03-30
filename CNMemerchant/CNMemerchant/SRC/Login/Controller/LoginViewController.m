//
//  LoginViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/3.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginHeaderView.h"
#import "LoginTableViewCell.h"
#import "LoginFirstViewController.h"
#import "LoginForgetViewController.h"

static NSString * const LoginTableViewCellID = @"LoginTableViewCellID";

@interface LoginViewController ()

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) LoginHeaderView *loginHeaderView;

@property (nonatomic, strong) UIView *footerView;

/** 账号 */
@property (nonatomic, copy) NSString *account;
/** 密码 */
@property (nonatomic, copy) NSString *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor color_FFFFFF];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self.tableView registerClass:[LoginTableViewCell class] forCellReuseIdentifier:LoginTableViewCellID];
}

#pragma mark -- request
- (void)virtualBusiness_accountLogin {
    self.account = @"XVQRU03296";
    self.password = @"123456";
    if (self.account.length == 0) {
        [MBProgressHUD showError:@"输入的账号有误，请重新输入"];
        return;
    }
    if (self.password.length == 0) {
        [MBProgressHUD showError:@"输入的密码有误，请重新输入"];
        return;
    }
    [self.view endEditing:YES];
    [RequestMacros virtualBusiness_accountLoginView:self.view parameters:@{@"account":self.account,@"password":self.password} success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        [[UserModel sharedInstance]reloadWithDic:obj];
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        if ([resultCode isEqualToString:@"16303"]) {
            //未绑定手机号
            LoginFirstViewController *loginFirstVC = [[LoginFirstViewController alloc]initWithLoginHeaderType:LoginHeaderFirst];
            loginFirstVC.account = self.account;
            [self.navigationController pushViewController:loginFirstVC animated:YES];
        } else {
            [MBProgressHUD showError:mes ToView:self.view];
        }
    }];
}
#pragma mark -- event
- (void)forgetPwBtnEvent:(UIButton *)sender {
    LoginForgetViewController *loginForgetVC = [[LoginForgetViewController alloc]init];
    [self.navigationController pushViewController:loginForgetVC animated:YES];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginTableViewCell *cell = (LoginTableViewCell *)[tableView dequeueReusableCellWithIdentifier: LoginTableViewCellID];
    WeakSelf;
    [cell reloadViewWithLoginTextFieldType:indexPath.row loginTextFieldEditBlock:^(NSString * _Nullable title) {
        if (indexPath.row == 0) {
            weakSelf.account = title;
        } else {
            weakSelf.password = title;
        }
    }];
    return cell;
}
#pragma mark -- setup
- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 25 + NAV_BAR_HEIGHT + login_header_heigth)];
        [headerV addSubview:self.loginHeaderView];
        [self.loginHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(headerV);
            make.top.equalTo(headerV).mas_offset(25 + NAV_BAR_HEIGHT);
            make.height.mas_equalTo(login_header_heigth);
        }];
        _headerView = headerV;
    }
    return _headerView;
}
- (LoginHeaderView *)loginHeaderView {
    if (!_loginHeaderView) {
        _loginHeaderView = [[LoginHeaderView alloc]init];
        [_loginHeaderView reloadViewWithLoginHeaderType:LoginHeaderLogin];
    }
    return _loginHeaderView;
}
- (UIView *)footerView {
    if (!_footerView) {
        UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 180)];
        UIButton *forgetPwBtn = [UIButton buttonWithTitle:@"忘记密码？" titleColor:[UIColor color_0054FF] font:SYSTEM_FONT_14];
        [forgetPwBtn addTarget:self action:@selector(forgetPwBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [footerV addSubview:forgetPwBtn];
        [forgetPwBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(footerV).mas_offset(-30);
            make.top.equalTo(footerV).mas_offset(20);
        }];
        WeakSelf;
        CommonButtonView *bottonView = [[CommonButtonView alloc]initWithTitle:@"登录" callBack:^{
            [weakSelf virtualBusiness_accountLogin];
        }];
        [footerV addSubview:bottonView];
        [bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(footerV);
            make.top.equalTo(forgetPwBtn.mas_bottom).mas_offset(45);
            make.height.mas_equalTo(common_button_height);
        }];
        _footerView = footerV;
    }
    return _footerView;
}

@end
