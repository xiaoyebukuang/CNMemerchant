//
//  WriteOffViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "WriteOffViewController.h"
#import "OrderDetailHeaderView.h"
#import "OrderDetailBottomView.h"

#import "UIAlertFieldView.h"

@interface WriteOffViewController ()<OrderDetailHeaderViewDelegate>


@property (nonatomic, strong) OrderDetailHeaderView *headerView;

@property (nonatomic, strong) OrderDetailBottomView *bottomView;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation WriteOffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"核销";
    [self setupUI];
    [self reloadView];
}
- (void)setupUI {
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(Normal_Spcae);
        make.top.equalTo(self.view).mas_offset(Normal_Spcae);
        make.right.equalTo(self.view).mas_offset(-Normal_Spcae);
    }];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.headerView);
        make.top.equalTo(self.headerView.mas_bottom).mas_offset(Normal_Spcae);
    }];
    [self.view addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).mas_offset(-30);
        make.top.equalTo(self.bottomView.mas_bottom).mas_offset(Normal_Spcae);
        make.width.mas_equalTo(92);
        make.height.mas_equalTo(32);
    }];
    
}
- (void)reloadView {
    [self.headerView reloadViewWithModel:self.orderModel];
    [self.bottomView reloadViewWithModel:self.orderModel];
    if (self.orderModel.orderState == OrderStateWaitPay) {
        self.cancelBtn.hidden = NO;
    } else {
        self.cancelBtn.hidden = YES;
    }
}
- (void)cancelBtnEvent {
    UIAlertFieldView *alertView = [[UIAlertFieldView alloc]initWithAlertFieldType:UIAlertFieldTypeSure];
    [alertView showAlertSureWithTitle:@"是否确认取消订单" callBack:^(NSInteger index) {
        [RequestMacros virtualBusiness_orderCancelView:self.view parameters:@{@"orderNo":self.orderModel.orderNo,@"cancelType":@"1"} success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
            self.orderModel.state = 3;
            [self reloadView];
        } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
            
        }];
    }];
}
#pragma mark -- OrderDetailHeaderViewDelegate
- (void)needToReloadView {
    [RequestMacros virtualBusiness_orderQueryView:self.view parameters:@{@"orderNo":self.orderModel.orderNo} success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        self.orderModel = [[OrderModel alloc]initWithDic:obj];
        [self reloadView];
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        
    }];
}
#pragma mark -- setup
- (OrderDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[OrderDetailHeaderView alloc]init];
        _headerView.delegate = self;
    }
    return _headerView;
}
- (OrderDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[OrderDetailBottomView alloc]init];
    }
    return _bottomView;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithTitle:@"取消订单" titleColor:[UIColor color_333333] font:SYSTEM_FONT_14];
        _cancelBtn.backgroundColor = [UIColor color_FFFFFF];
        _cancelBtn.layer.borderWidth = 0.5;
        _cancelBtn.layer.borderColor = [UIColor color_EEEEEE].CGColor;
        _cancelBtn.layer.cornerRadius = 16;
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn addTarget:self action:@selector(cancelBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}



@end
