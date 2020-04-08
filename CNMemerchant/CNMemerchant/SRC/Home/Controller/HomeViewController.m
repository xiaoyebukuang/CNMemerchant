//
//  HomeViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/5.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "HomeViewController.h"
#import "OrderListViewController.h"

#import "UIRadianLayerView.h"
#import "HomeOrderView.h"
#import "HomeTableViewCell.h"
#import "HomeStateTableViewCell.h"

#import "BusinessOrderModel.h"


static NSString * const HomeTableViewCellID = @"HomeTableViewCellID";
static NSString * const HomeStateTableViewCellID = @"HomeStateTableViewCellID";

static CGFloat const SECTION_NAME_HEIGHT = 46.0f;

@interface HomeViewController ()<HomeOrderViewDelegate>

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UILabel *scetionLabel;

@property (nonatomic, strong) HomeOrderView *orderView;
/** 数据源 */
@property (nonatomic, strong) BusinessOrderModel *businessOrderModel;
/** 当前数据状态 */
@property (nonatomic, assign) HomeState homeState;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.businessOrderModel = [[BusinessOrderModel alloc]init];
    self.homeState = HomeStateLoading;
}
- (void)setupUI {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.view);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT - TAB_BAR_HEIGHT);
    }];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:HomeTableViewCellID];
    [self.tableView registerClass:[HomeStateTableViewCell class] forCellReuseIdentifier:HomeStateTableViewCellID];
    WeakSelf;
    [self.tableView addRefreshHiddenStateBar:NO headerBlock:^{
        [weakSelf virtualBusiness_orderListIsRequest:YES];
        [weakSelf virtualBusiness_orderStatis];
    } footerBlock:^{
        [weakSelf virtualBusiness_orderListIsRequest:NO];
    }];
    [self.tableView beginRefresh];
}
#pragma mark -- 设置状态
- (void)setHomeState:(HomeState)homeState {
    _homeState = homeState;
    switch (homeState) {
        case HomeStateNoData:
        case HomeStateRequestFailed:
        {
            //无数据//请求失败
            [self.tableView setFooterRefreshHidden:YES];
            [self.tableView reloadData];
        }
            break;
        case HomeStateHasData:
        {
            //请求成功并有数据
            [self.tableView setFooterRefreshHidden:NO];
            [self.tableView reloadData];
        }
            break;
        default:
            break;
    }
}
#pragma mark -- request
- (void)virtualBusiness_orderStatis {
    [self.orderView initializationView];
    [RequestMacros virtualBusiness_orderStatisParameters:@{@"stationCode":[UserModel sharedInstance].stationCode} success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        [self.orderView reloadViewWithDataDic:obj];
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        [self.tableView endRefresh];
    }];
}
- (void)virtualBusiness_orderListIsRequest:(BOOL)isRefresh {
    NSString *pageNum = isRefresh?@"1":[NSString stringWithFormat:@"%d",(int)self.businessOrderModel.pageNum + 1];
    NSString *queryDate = [NSDate getDateStrWithDate:[NSDate date] formatType:FormatyyyyMd];
    NSDictionary *parameters = @{@"pageNum":pageNum,
                                 @"pageSize":[NSString stringWithFormat:@"%ld",(long)self.businessOrderModel.pageSize],
                                 @"stationCode":[UserModel sharedInstance].stationCode,
                                 @"queryDate":queryDate};
    self.homeState = HomeStateLoading;
    [RequestMacros virtualBusiness_orderListView:self.view parameters:parameters success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        [self.tableView endRefresh];
        if (isRefresh) {
            [self.businessOrderModel.orderList removeAllObjects];
            [self.tableView layoutIfNeeded];
        }
        [self.businessOrderModel reloadDataDic:obj refresh:isRefresh];
        if (self.businessOrderModel.orderList.count == 0) {
            self.homeState = HomeStateNoData;
        } else {
            self.homeState = HomeStateHasData;
            if (!self.businessOrderModel.isContinue) {
                [self.tableView endRefreshNoMoreData];
            }
        }
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        [self.tableView endRefresh];
        if (self.businessOrderModel.orderList.count == 0) {
            self.homeState = HomeStateRequestFailed;
        } else {
            [MBProgressHUD showError:mes ToView:self.view];
        }
    }];
}


#pragma mark -- HomeOrderViewDelegate
- (void)gotoOrderListVC {
    OrderListViewController *orderListVC = [[OrderListViewController alloc]init];
    [self.navigationController pushViewController:orderListVC animated:YES];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
/** 段头高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80 + NAV_BAR_HEIGHT + 25 + SECTION_NAME_HEIGHT;
}
/** 段头view */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.homeState == HomeStateHasData) {
        return self.businessOrderModel.orderList.count;
    }
    if (self.homeState == HomeStateLoading && self.businessOrderModel.orderList.count > 0) {
        return self.businessOrderModel.orderList.count;
    }
    if (self.homeState == HomeStateNoData || self.homeState == HomeStateRequestFailed) {
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.homeState == HomeStateHasData || (self.homeState == HomeStateLoading && self.businessOrderModel.orderList.count > 0)) {
        OrderModel *orderModel = self.businessOrderModel.orderList[indexPath.row];
        HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier: HomeTableViewCellID];
        [cell reloadViewWithModel:orderModel isHome:YES];
        return cell;
    } else {
        HomeStateTableViewCell *cell = (HomeStateTableViewCell *)[tableView dequeueReusableCellWithIdentifier: HomeStateTableViewCellID];
        WeakSelf;
        [cell reloadViewWithHomeState:self.homeState isAll:NO homeStateBlock:^{
            if (weakSelf.homeState == HomeStateRequestFailed) {
                [weakSelf.tableView beginRefresh];
            }
        }];
        return cell;
    }
}
#pragma makr -- setup
- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerV = [[UIView alloc]init];
        headerV.backgroundColor = [UIColor color_main];
        UIRadianLayerView *radianLayerView = [[UIRadianLayerView alloc]initWithHieght:80 + NAV_BAR_HEIGHT];
        [headerV addSubview:radianLayerView];
        [radianLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.width.equalTo(headerV);
            make.height.mas_equalTo(80 + NAV_BAR_HEIGHT);
        }];
        UILabel *titleLabel = [[UILabel alloc]initWithText:[UserModel sharedInstance].stationName textColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_B_18];
        [headerV addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerV);
            make.top.equalTo(headerV).mas_offset(NAV_STA_HEIGHT);
            make.height.mas_equalTo(NAV_BAR_NORMAL_HEIGHT);
        }];
        [headerV addSubview:self.orderView];
        [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerV).mas_offset(Normal_Spcae);
            make.top.equalTo(radianLayerView.mas_bottom).mas_offset(-65);
            make.centerX.equalTo(headerV);
            make.height.mas_equalTo(90);
        }];
        [headerV addSubview:self.scetionLabel];
        [self.scetionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.orderView);
            make.top.equalTo(self.orderView.mas_bottom);
            make.height.mas_equalTo(SECTION_NAME_HEIGHT);
        }];
        _headerView = headerV;
    }
    return _headerView;
}
- (HomeOrderView *)orderView {
    if (!_orderView) {
        _orderView = [[HomeOrderView alloc]init];
        _orderView.delegate = self;
    }
    return _orderView;
}
- (UILabel *)scetionLabel {
    if (!_scetionLabel) {
        _scetionLabel = [[UILabel alloc]initWithText:@"今日订单" textColor:[UIColor color_333333] font:SYSTEM_FONT_B_16];
    }
    return _scetionLabel;
}


@end
