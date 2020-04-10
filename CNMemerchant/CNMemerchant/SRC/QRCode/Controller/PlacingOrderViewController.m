//
//  PlacingOrderViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/18.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "PlacingOrderViewController.h"
#import "CommonHeaderTableView.h"
#import "LoginTableViewCell.h"
#import "AccountQueryStationView.h"

#import "ProduceListModel.h"
#import "BusinessOrderModel.h"
#import "WriteOffViewController.h"

static NSString * const LoginTableViewCellID = @"LoginTableViewCellID";

@interface PlacingOrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CommonButtonView *bottonView;

@property (nonatomic, strong) ProduceListModel *selectModel;

/** 订单金额 */
@property (nonatomic, copy) NSString *amount;
/** 加油量 */
@property (nonatomic, copy) NSString *oilLiters;



@end

@implementation PlacingOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"核销";
    [self setupUI];
}
- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(Normal_Spcae);
        make.top.equalTo(self.view).mas_offset(Normal_Spcae);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(COMMON_CELL_HEIGHT*4);
    }];
    [self.view addSubview:self.bottonView];
    [self.bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(-IPHONEX_BOTTOW_HEIGHT);
        make.height.mas_equalTo(NAV_BAR_NORMAL_HEIGHT);
    }];
    [self.tableView registerClass:[LoginTableViewCell class] forCellReuseIdentifier:LoginTableViewCellID];
}
#pragma mark -- request
- (void)virtualBusiness_orderCreate {
    NSString *errorStr;
    if (self.selectModel.oilCode == 0) {
        errorStr = @"请选择油品";
    } else if (self.oilLiters.length == 0) {
        errorStr = @"请输入加油升数";
    } else if (self.amount.length == 0) {
        errorStr = @"请输入消费金额";
    } else if (self.oilLiters.intValue >= 1000) {
        errorStr = @"加油量已超过限制";
    } else if (self.amount.intValue >= 100000) {
        errorStr = @"消费金额已超过限制";
    } else if ([self.oilLiters containsString:@"."] || [self.amount containsString:@"."]) {
        NSArray *oilArray = [self.oilLiters componentsSeparatedByString:@"."];
        if (oilArray.count == 2) {
            NSString *pointStr = oilArray[1];
            if (pointStr.length > 2) {
                errorStr = @"加油量小数输入有误";
            }
        }
        if (errorStr.length == 0) {
            NSArray *amountArray = [self.amount componentsSeparatedByString:@"."];
            if (amountArray.count == 2) {
                NSString *pointStr = amountArray[1];
                if (pointStr.length > 2) {
                    errorStr = @"消费金额小数输入有误";
                }
            }
        }
    }
    if (errorStr.length > 0) {
        [MBProgressHUD showError:errorStr ToView:self.view];
        return;
    }
    NSDictionary *parameters = @{@"stationCode":[UserModel sharedInstance].stationCode,
                                 @"userCode":self.userCode,
                                 @"oilCode":self.selectModel.oilCode,
                                 @"virtualOilcard":self.virtualOilcard,
                                 @"amount":self.amount,
                                 @"oilLiters":self.oilLiters};
    [RequestMacros virtualBusiness_orderCreateView:self.view parameters:parameters success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        self.removeWhenPush = YES;
        OrderModel *orderModel = [[OrderModel alloc]initWithDic:obj];
        WriteOffViewController *wovc = [[WriteOffViewController alloc]init];
        wovc.orderModel = orderModel;
        [self.navigationController pushViewController:wovc animated:YES];
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        
    }];
}
/** 查询站点信息 */
- (void)virtualBusiness_accountQueryStation {
    [RequestMacros virtualBusiness_accountQueryStationView:self.view success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        NSArray *productList = obj[@"productList"];
        NSMutableArray *modelArray = [NSMutableArray array];
        if ([productList isKindOfClass:[NSArray class]]) {
            for (NSDictionary *subDic in productList) {
                if ([subDic isKindOfClass:[NSDictionary class]]) {
                    ProduceListModel *listModel = [[ProduceListModel alloc]initWithDic:subDic];
                    [modelArray addObject:listModel];
                }
            }
        }
        if (modelArray.count > 0) {
            [AccountQueryStationView showAccountQueryStationViewWithModelArray:modelArray accountQueryStationCallBlock:^(ProduceListModel * _Nonnull produceListModel) {
                self.selectModel = produceListModel;
                [self.tableView reloadData];
            }];
        } else {
            [MBProgressHUD showError:@"暂无油品" ToView:self.view];
        }
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        
    }];
}
#pragma mark -- UITableViewDelegate, UITableViewDataSource
/** 段头高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return COMMON_CELL_HEIGHT;
}
/** 段头view */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CommonHeaderTableView *sectionView = [[CommonHeaderTableView alloc]initWithImageName:@"write_off_card" title:[NSString stringWithFormat:@"卡号：%@",self.virtualOilcard]];
    return sectionView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoginTableViewCell *cell = (LoginTableViewCell *)[tableView dequeueReusableCellWithIdentifier: LoginTableViewCellID];
    NSArray *contents = @[[NSString safe_string:self.selectModel.oilName],
                          [NSString safe_string:self.oilLiters],
                          [NSString safe_string:self.amount]];
    NSArray *types = @[@(LoginTextFieldOilType),
                       @(LoginTextFieldOilQuantity),
                       @(LoginTextFieldConsumptionAmount)];
    WeakSelf;
    [cell reloadViewWithLoginTextFieldType:[NSString safe_string:types[indexPath.row]].intValue content:contents[indexPath.row] loginTextFieldEditBlock:^(NSString * _Nullable title) {
        if (indexPath.row == 1) {
            weakSelf.oilLiters = title;
        }
        if (indexPath.row == 2) {
            weakSelf.amount = title;
        }
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self virtualBusiness_accountQueryStation];
    }
}
#pragma mark -- setup
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.bounces = NO;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 10;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0,*)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        }
    }
    return _tableView;
}
- (CommonButtonView *)bottonView {
    if (!_bottonView) {
        WeakSelf;
        _bottonView = [[CommonButtonView alloc]initBottomWithTitle:@"确认加油" callBack:^{
            [weakSelf virtualBusiness_orderCreate];
        }];
    }
    return _bottonView;
}
@end
