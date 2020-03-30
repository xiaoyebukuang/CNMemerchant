//
//  BusinessOrderModel.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/16.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BusinessOrderModel.h"

@implementation BusinessOrderModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.pageNum = 0;
        self.pageSize = 10;
        self.totalCount = 0;
        self.isContinue = NO;
        self.orderList = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)reloadDataDic:(NSDictionary *)dic refresh:(BOOL)refresh {
    if (refresh) {
        self.pageNum = 1;
        [self.orderList removeAllObjects];
    } else {
        self.pageNum = self.pageNum + 1;
    }
    self.totalCount = [NSString safe_integer:dic[@"totalCount"]];
    NSInteger unit = self.totalCount%self.pageSize;
    NSInteger decade = self.totalCount/self.pageSize;
    NSInteger allPage = decade + (unit == 0? 0:1);
    if (self.pageNum >= allPage) {
        self.isContinue = NO;
    } else {
        self.isContinue = YES;
    }
    NSArray *orderL = dic[@"orderList"];
    if ([orderL isKindOfClass:[NSArray class]]) {
        for (NSDictionary *subDic in orderL) {
            if ([subDic isKindOfClass:[NSDictionary class]]) {
                OrderModel *model = [[OrderModel alloc]initWithDic:subDic];
                [self.orderList addObject:model];
            }
        }
    }
}
@end

@implementation OrderModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.state = [NSString safe_int:dic[@"state"]];
        self.oilLiters = [NSString safe_string:dic[@"oilLiters"]];
        self.oilCode = [NSString safe_string:dic[@"oilCode"]];
        self.oilName = [NSString safe_string:dic[@"oilName"]];
        self.amount = [NSString safe_string:dic[@"amount"]];
        self.orderNo = [NSString safe_string:dic[@"orderNo"]];
        self.virtualOilcard = [NSString safe_string:dic[@"virtualOilcard"]];
        if (self.virtualOilcard.length >= 8) {
            NSString *muStr = @"";
            for (int i = 0; i < self.virtualOilcard.length - 8; i ++) {
                muStr = [muStr stringByAppendingString:@"*"];
            }
            self.virtualOilcard = [self.virtualOilcard stringByReplacingCharactersInRange:NSMakeRange(4, self.virtualOilcard.length - 8) withString:muStr];
        }
        self.stationCode = [NSString safe_string:dic[@"stationCode"]];
        self.userCode = [NSString safe_string:dic[@"userCode"]];
        self.delState = [NSString safe_int:dic[@"delState"]];
        self.createDateStr = [NSString safe_string:dic[@"createDateStr"]];
        self.cancelType = [NSString safe_int:dic[@"cancelType"]];
        self.updateDateStr = [NSString safe_string:dic[@"updateDateStr"]];
    }
    return self;
}
- (void)setState:(NSInteger)state {
    _state = state;
    switch (state) {
        case 1:
        {
            //待付款
            self.orderState = OrderStateWaitPay;
            self.stateName = @"待确认";
            self.stateColor = [UIColor color_FD7E2D];
            self.stateDetailName = @"订单提交成功\n等待客户确认";
            self.imageName = @"order_wait_pay";
            self.stateDetailDes = @"*5分钟内未确认，订单自动取消，还请提醒客户及时确认";
        }
            break;
        case 2:
        {
            //交易成功
            self.orderState = OrderStateSucess;
            self.stateName = @"交易成功";
            self.stateColor = [UIColor color_FFC61C];
            self.stateDetailName = @"客户已支付";
            self.imageName = @"order_sucess";
            self.stateDetailDes = @"";
        }
            break;
        case 3:
        {
            //已取消
            self.orderState = OrderStateCancel;
            self.stateName = @"已取消";
            self.stateColor = [UIColor color_CCCCCC];
            if (self.cancelType == 3) {
                self.stateDetailName = @"订单已超时取消";
                self.stateDetailDes = @"*5分钟内未确认，超时已取消";
                self.imageName = @"order_time_cancel";
            } else {
                self.stateDetailName = @"订单已取消";
                self.stateDetailDes = @"";
                self.imageName = @"order_time_cancel";
            }
        }
            break;
        case 4:
        {
            //退款成功
            self.orderState = OrderStateRefundSuc;
            self.stateName = @"退款成功";
            self.stateColor = [UIColor color_2296FF];
            self.stateDetailName = @"订单已退款";
            self.imageName = @"order_refund_suc";
            self.stateDetailDes = @"";
        }
            break;
        default:
            break;
    }
}

@end
