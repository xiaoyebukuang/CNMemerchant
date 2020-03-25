//
//  MineViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineSiteInfoView.h"
#import "UIStateView.h"
#import "MineOilTypeView.h"

#import "LoginFirstViewController.h"
@interface MineViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollV;
/** 状态栏 */
@property (nonatomic, strong) UIStateView *stateView;
/** 头部信息 */
@property (nonatomic, strong) MineHeaderView *headerView;
/** 站点信息 */
@property (nonatomic, strong) MineSiteInfoView *siteInfoView;
/** 提供油品 */
@property (nonatomic, strong) MineOilTypeView *oilTypeView;
/** 重置密码 */
@property (nonatomic, strong) UIButton *resetBtn;
/** 退出登录 */
@property (nonatomic, strong) CommonButtonView *bottonView;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self virtualBusiness_accountQueryStation];
}
- (void)setupUI {
    [self.view addSubview:self.mainScrollV];
    [self.mainScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.view);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT - TAB_BAR_HEIGHT);
    }];
    [self.mainScrollV addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.mainScrollV);
    }];
    [self.mainScrollV addSubview:self.siteInfoView];
    [self.siteInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).mas_offset(-60);
        make.left.equalTo(self.mainScrollV).mas_offset(Normal_Spcae);
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH - 2*Normal_Spcae);
    }];
    [self.mainScrollV addSubview:self.oilTypeView];
    [self.oilTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.siteInfoView.mas_bottom).mas_offset(Normal_Spcae);
        make.left.width.equalTo(self.siteInfoView);
        make.height.mas_equalTo(0);
    }];
    [self.mainScrollV addSubview:self.resetBtn];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oilTypeView.mas_bottom);
        make.left.width.equalTo(self.siteInfoView);
        make.height.mas_equalTo(50);
    }];
    [self.mainScrollV addSubview:self.bottonView];
    [self.bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resetBtn.mas_bottom).mas_offset(Normal_Spcae);
        make.left.width.equalTo(self.siteInfoView);
        make.height.mas_equalTo(common_button_height);
        make.bottom.equalTo(self.mainScrollV).mas_offset(-25);
    }];
    [self.view addSubview:self.stateView];
    [self.stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.view);
        make.height.mas_equalTo(NAV_BAR_HEIGHT);
    }];
}
#pragma mark -- event
- (void)resetBtnEvent {
    LoginFirstViewController *loginFirstVC = [[LoginFirstViewController alloc]init];
    loginFirstVC.loginHeaderType = LoginHeaderReset;
    [self.navigationController pushViewController:loginFirstVC animated:YES];
}
#pragma mark -- request
/** 查询站点信息 */
- (void)virtualBusiness_accountQueryStation {
    [RequestMacros virtualBusiness_accountQueryStationView:self.view success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        [self.oilTypeView reloadViewWithDic:obj];
        CGFloat reset_btn_height = self.oilTypeView.hidden?0:Normal_Spcae;
        [self.resetBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.oilTypeView.mas_bottom).mas_offset(reset_btn_height);
        }];
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        WeakSelf;
        [CommonInfoView showInfoViewSuperView:self.view commonInfoType:CommonInfoNetworkNone commonInfoBlock:^(CommonInfoView *infoView) {
            [weakSelf virtualBusiness_accountQueryStation];
        }];
    }];
}
/** 退出 */
- (void)virtualBusiness_accountLogout {
    [UIAlertViewTool showTitle:@"提示" message:@"是否退出" alertBlock:^(NSString *mes, NSInteger index) {
        if (index == 1) {
            [RequestMacros virtualBusiness_accountLogoutView:self.view success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
                [[UserModel sharedInstance]signOut];
            } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
                
            }];
        }
    }];
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = 100;
    CGFloat alpha = scrollView.contentOffset.y/height;
    [self.stateView changeAlphaWithAlpha:alpha];
    if (scrollView.contentOffset.y < 0) {
        [self.stateView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-scrollView.contentOffset.y);
        }];
    } else {
        [self.stateView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
        }];
    }
}

#pragma makr -- setup
- (UIStateView *)stateView {
    if (!_stateView) {
        _stateView = [[UIStateView alloc]initWithTitle:@"我的"];
    }
    return _stateView;
}
- (UIScrollView *)mainScrollV {
    if (!_mainScrollV) {
        _mainScrollV = [[UIScrollView alloc] init];
        _mainScrollV.showsHorizontalScrollIndicator = NO;
        _mainScrollV.showsVerticalScrollIndicator = NO;
        _mainScrollV.delegate = self;
        if (@available(iOS 11.0,*)) {
            _mainScrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _mainScrollV;
}
- (MineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc]init];
    }
    return _headerView;
}
- (MineSiteInfoView *)siteInfoView {
    if (!_siteInfoView) {
        _siteInfoView = [[MineSiteInfoView alloc]init];
    }
    return _siteInfoView;
}
- (MineOilTypeView *)oilTypeView {
    if (!_oilTypeView) {
        _oilTypeView = [[MineOilTypeView alloc]init];
        _oilTypeView.hidden = YES;
    }
    return _oilTypeView;
}
- (UIButton *)resetBtn {
    if (!_resetBtn) {
        UIButton *resetB = [UIButton buttonWithType:UIButtonTypeSystem];
        [resetB addTarget:self action:@selector(resetBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        resetB.backgroundColor = [UIColor color_FFFFFF];
        resetB.layer.cornerRadius = 10;
        resetB.layer.masksToBounds = YES;
        UILabel *label = [[UILabel alloc]initWithText:@"重置密码" textColor:[UIColor color_333333] font:SYSTEM_FONT_B_14];
        [resetB addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(resetB).mas_offset(Normal_Spcae);
            make.centerY.equalTo(resetB);
        }];
        UIImageView *arrowImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_arrow"]];
        [resetB addSubview:arrowImageV];
        [arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(resetB).mas_offset(-Normal_Spcae);
            make.centerY.equalTo(resetB);
        }];
        _resetBtn = resetB;
    }
    return _resetBtn;
}
- (CommonButtonView *)bottonView {
    if (!_bottonView) {
        WeakSelf;
        _bottonView = [[CommonButtonView alloc]initWithTitle:@"退出登录" callBack:^{
            [weakSelf virtualBusiness_accountLogout];
        }];
    }
    return _bottonView;
}

@end
