//
//  OrderListViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/6.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "OrderListViewController.h"
#import "HomeTableViewCell.h"
#import "HomeStateTableViewCell.h"
#import "BusinessOrderModel.h"
#import "CalenderViewController.h"
static NSString * const HomeTableViewCellID = @"HomeTableViewCellID";
static NSString * const HomeStateTableViewCellID = @"HomeStateTableViewCellID";
@interface OrderListViewController ()<CalenderViewControllerDelegate>
/** 数据源 */
@property (nonatomic, strong) BusinessOrderModel *businessOrderModel;
/** 当前数据状态 */
@property (nonatomic, assign) HomeState homeState;

@property (nonatomic, copy) NSString *queryDate;

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单";
    self.businessOrderModel = [[BusinessOrderModel alloc]init];
    [self setRightNavigationBarWithImageStr:@"nav_btn_order"];
    [self setupUI];
}
- (void)setupUI {
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:HomeTableViewCellID];
    [self.tableView registerClass:[HomeStateTableViewCell class] forCellReuseIdentifier:HomeStateTableViewCellID];
    WeakSelf;
    [self.tableView addRefreshHiddenStateBar:NO headerBlock:^{
        [weakSelf virtualBusiness_orderListIsRequest:YES];
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
- (void)virtualBusiness_orderListIsRequest:(BOOL)isRefresh {
    NSString *pageNum = isRefresh?@"1":[NSString stringWithFormat:@"%d",(int)self.businessOrderModel.pageNum + 1];
    NSDictionary *parameters = @{@"pageNum":pageNum,
                                 @"pageSize":[NSString stringWithFormat:@"%ld",(long)self.businessOrderModel.pageSize],
                                 @"stationCode":[UserModel sharedInstance].stationCode,
                                 @"queryDate":[NSString safe_string:self.queryDate]};
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
#pragma mark -- CalenderViewControllerDelegate
- (void)didSelectDateStrWithDateStr:(NSString *)dateStr {
    self.queryDate = dateStr;
    [self virtualBusiness_orderListIsRequest:YES];
}
#pragma mark -- setup
- (void)rightNavigationBarEvent:(UIButton *)sender {
    CalenderViewController *calenderVC = [[CalenderViewController alloc]init];
    calenderVC.startDateStr = [NSDate getDateStrWithDate:[NSDate date] afterSecond:-60*60*24*365 formatType:FormatyyyyMd];
    calenderVC.endDateStr = [NSDate getDateStrWithDate:[NSDate date] formatType:FormatyyyyMd];
    if (self.queryDate.length == 0) {
        calenderVC.selectDateStr = [NSDate getDateStrWithDate:[NSDate date] formatType:FormatyyyyMd];
    } else {
        calenderVC.selectDateStr = self.queryDate;
    }
    calenderVC.delegate = self;
    [self.navigationController pushViewController:calenderVC animated:YES];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
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
        [cell reloadViewWithModel:orderModel];
        return cell;
    } else {
        HomeStateTableViewCell *cell = (HomeStateTableViewCell *)[tableView dequeueReusableCellWithIdentifier: HomeStateTableViewCellID];
        WeakSelf;
        [cell reloadViewWithHomeState:self.homeState isAll:YES homeStateBlock:^{
            if (weakSelf.homeState == HomeStateRequestFailed) {
                [weakSelf.tableView beginRefresh];
            }
        }];
        return cell;
    }
}
@end
