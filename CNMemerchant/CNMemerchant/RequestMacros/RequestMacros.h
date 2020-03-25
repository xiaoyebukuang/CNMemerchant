//
//  RequestMacros.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/2.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetworking.h"

NS_ASSUME_NONNULL_BEGIN

//TODO:请求环境
typedef NS_ENUM(NSInteger, RequestEnvironment) {
    RequestEnvironmentDev,           //开发
    RequestEnvironmentUat,           //uat
    RequestEnvironmentDis,           //生产
};

@interface RequestMacros : NSObject

@property (nonatomic, assign) RequestEnvironment requestEnvironment;

@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *appSecretKey;
@property (nonatomic, copy) NSString *appSecretGiv;

+ (instancetype) shareInstance;

/** 1.登录 */
+ (void)virtualBusiness_accountLoginView:(UIView *)view
                              parameters:(id)parameters
                                 success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                 failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;
/** 2.重置密码&第一次登录 */
+ (void)virtualBusiness_accountResetPasswordView:(UIView *)view
                                      parameters:(id)parameters
                                         success:(void (^)(id obj, NSString *resultDesc))success
                                         failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;

/** 3.验证码 */
+ (void)virtualBusiness_accountSendParameters:(id)parameters
                                      success:(void (^)(id obj, NSString *resultDesc))success
                                      failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;

/** 4.忘记密码 */
+ (void)virtualBusiness_accountForgetPasswordView:(UIView *)view
                                       parameters:(id)parameters
                                          success:(void (^)(id obj, NSString *resultDesc))success
                                          failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;
/** 5.退出登录 */
+ (void)virtualBusiness_accountLogoutView:(UIView *)view
                                  success:(void (^)(id obj, NSString *resultDesc))success
                                  failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;

/** 6.查询站点信息 */
+ (void)virtualBusiness_accountQueryStationView:(UIView *)view
                                        success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                        failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;

/** 7.商户订单列表 */
+ (void)virtualBusiness_orderListView:(UIView *)view
                           parameters:(id)parameters
                              success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                              failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;

/** 8.商户订单统计信息 */
+ (void)virtualBusiness_orderStatisParameters:(id)parameters
                                      success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                      failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;

/** 9.用户储值油卡扫描 */
+ (void)virtualRecharge_oilcardScanInfoView:(UIView *)view
                                 parameters:(id)parameters
                                    success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                    failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;

/** 10.创建商户订单 */
+ (void)virtualBusiness_orderCreateView:(UIView *)view
                             parameters:(id)parameters
                                success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;

/** 11.查询商户订单信息 */
+ (void)virtualBusiness_orderQueryView:(UIView *)view
                            parameters:(id)parameters
                               success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                               failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;

/** 12.取消订单 */
+ (void)virtualBusiness_orderCancelView:(UIView *)view
                             parameters:(id)parameters
                                success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure;


@end

NS_ASSUME_NONNULL_END
