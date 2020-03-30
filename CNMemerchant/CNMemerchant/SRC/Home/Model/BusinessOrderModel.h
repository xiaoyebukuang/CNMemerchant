//
//  BusinessOrderModel.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/16.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HomeState) {
    HomeStateLoading,           //加载中
    HomeStateNoData,            //无数据
    HomeStateRequestFailed,     //请求失败
    HomeStateHasData            //请求成功并有数据
};
typedef NS_ENUM(NSInteger, OrderState) {
    OrderStateWaitPay,            //待付款
    OrderStateSucess,             //交易成功
    OrderStateCancel,             //已取消
    OrderStateRefundSuc,          //退款成功
};


@interface BusinessOrderModel : NSObject

//请求的页码
@property (nonatomic, assign) NSInteger pageNum;
//请求的条数
@property (nonatomic, assign) NSInteger pageSize;
//总条数
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, assign) BOOL isContinue;

@property (nonatomic, strong) NSMutableArray *orderList;

- (void)reloadDataDic:(NSDictionary *)dic refresh:(BOOL)refresh;


@end

@interface OrderModel : NSObject

/** 订单状态 1 待付款，2 交易成功，3 已取消，4 退款成功 */
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) OrderState orderState;
@property (nonatomic, copy) NSString *stateName;
@property (nonatomic, copy) NSString *stateDetailName;
@property (nonatomic, copy) NSString *stateDetailDes;
@property (nonatomic, strong) UIColor *stateColor;
@property (nonatomic, copy) NSString *imageName;

/** 加油量 单位升 */
@property (nonatomic, copy) NSString *oilLiters;
/** 油品编码 */
@property (nonatomic, copy) NSString *oilCode;
/** 油品名称 */
@property (nonatomic, copy) NSString *oilName;
/** 价格 */
@property (nonatomic, copy) NSString *amount;
/** 订单号 */
@property (nonatomic, copy) NSString *orderNo;
/** 虚拟油卡 */
@property (nonatomic, copy) NSString *virtualOilcard;
/** 油站编码 */
@property (nonatomic, copy) NSString *stationCode;
/** 用户code */
@property (nonatomic, copy) NSString *userCode;
/** 是否可用 */
@property (nonatomic, assign) NSInteger delState;
/** 订单创建时间 */
@property (nonatomic, copy) NSString *createDateStr;
/** 订单更新时间 */
@property (nonatomic, copy) NSString *updateDateStr;

/** 取消方式 */
@property (nonatomic, assign) NSInteger cancelType;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
