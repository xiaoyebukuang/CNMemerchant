//
//  RequestMacros.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/2.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "RequestMacros.h"

#define API_BASE_URL                        @"https://app.chengniu.com"
static NSString * const APP_SECRET_KEY   = @"7FAFB8D5";
static NSString * const giv              = @"2A44A90B";

static RequestMacros *_requestMacros = nil;


@interface RequestMacros()

@end

@implementation RequestMacros

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _requestMacros = [[self alloc] init];
    });
    return _requestMacros;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestEnvironment = RequestEnvironmentDev;
    }
    return self;
}
- (void)setRequestEnvironment:(RequestEnvironment)requestEnvironment {
    _requestEnvironment = requestEnvironment;
    switch (requestEnvironment) {
        case RequestEnvironmentDev:
            self.baseUrl = @"https://test.chengniu.com:9102";
            self.appSecretKey = @"D5ED1E14";
            self.appSecretGiv = @"9ACBE716";
            break;
        case RequestEnvironmentUat:
            self.baseUrl = @"https://uatapp.chengniu.com";
            self.appSecretKey = @"7FAFB8D5";
            self.appSecretGiv = @"2A44A90B";
            break;
        case RequestEnvironmentDis:
            self.baseUrl = @"https://app.chengniu.com";
            self.appSecretKey = @"7FAFB8D5";
            self.appSecretGiv = @"2A44A90B";
            break;
    }
}
/** 1.登录 */
+ (void)virtualBusiness_accountLoginView:(UIView *)view
                              parameters:(id)parameters
                                 success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                 failure:(void (^__strong _Nonnull)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/account/login",requestMacros.baseUrl];
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD hideHUDForView:view];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success(obj,resultDesc);
        } else {
            [MBProgressHUD showError:@"登录失败" ToView:view];
        }
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD hideHUDForView:view];
        failure(errorType, mes, resultCode);
    }];
}
/** 2.重置密码&第一次登录 */
+ (void)virtualBusiness_accountResetPasswordView:(UIView *)view
                                      parameters:(id)parameters
                                         success:(void (^)(id obj, NSString *resultDesc))success
                                         failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/account/resetPassword",requestMacros.baseUrl];
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD hideHUDForView:view];
        [MBProgressHUD showSuccess:@"重置密码成功，请重新登录" completeBlcok:^{
            success(obj,resultDesc);
        }];
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes, resultCode);
    }];
}
/** 3.验证码 */
+ (void)virtualBusiness_accountSendParameters:(id)parameters
                                      success:(void (^)(id obj, NSString *resultDesc))success
                                      failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/account/send",requestMacros.baseUrl];
    [MBProgressHUD showWindow];
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD showSuccess:@"验证码发送成功"];
        success(obj,resultDesc);
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD showError:mes];
    }];
}
/** 4.忘记密码 */
+ (void)virtualBusiness_accountForgetPasswordView:(UIView *)view
                                       parameters:(id)parameters
                                          success:(void (^)(id obj, NSString *resultDesc))success
                                          failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/account/forgetPassword",requestMacros.baseUrl];
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD hideHUDForView:view];
        [MBProgressHUD showSuccess:@"修改密码成功，请重新登录" completeBlcok:^{
            success(obj,resultDesc);
        }];
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes, resultCode);
    }];
}
/** 5.退出登录 */
+ (void)virtualBusiness_accountLogoutView:(UIView *)view
                                  success:(void (^)(id obj, NSString *resultDesc))success
                                  failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/account/logout",requestMacros.baseUrl];
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:urlStr success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD hideHUDForView:view];
        [MBProgressHUD showSuccess:@"退出成功" completeBlcok:^{
            success(obj,resultDesc);
        }];
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes, resultCode);
    }];
}


/** 6.查询站点信息 */
+ (void)virtualBusiness_accountQueryStationView:(UIView *)view
                                        success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                        failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/account/queryStation",requestMacros.baseUrl];
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:urlStr success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD hideHUDForView:view];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success(obj,resultDesc);
        }
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes, resultCode);
    }];
}
/** 7.商户订单列表 */
+ (void)virtualBusiness_orderListView:(UIView *)view
                           parameters:(id)parameters
                              success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                              failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/order/list",requestMacros.baseUrl];
    if (view) {
//        [MBProgressHUD showToView:view];
    }
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
//        [MBProgressHUD hideHUDForView:view];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success(obj,resultDesc);
        }
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
//        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes, resultCode);
    }];
}
/** 8.商户订单统计信息 */
+ (void)virtualBusiness_orderStatisParameters:(id)parameters
                                      success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                      failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/order/statis",requestMacros.baseUrl];
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success(obj,resultDesc);
        }
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        failure(errorType, mes, resultCode);
    }];
}
/** 9.用户储值油卡扫描 */
+ (void)virtualRecharge_oilcardScanInfoView:(UIView *)view
                                 parameters:(id)parameters
                                    success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                    failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/recharge/oilcard/scanInfo",requestMacros.baseUrl];
    if (view) {
        [MBProgressHUD showToView:view];
    }
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD hideHUDForView:view];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success(obj,resultDesc);
        }
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD showError:mes ToView:view completeBlcok:^{
            failure(errorType, mes, resultCode);
        }];
    }];
}

/** 10.创建商户订单 */
+ (void)virtualBusiness_orderCreateView:(UIView *)view
                             parameters:(id)parameters
                                success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/order/create",requestMacros.baseUrl];
    if (view) {
        [MBProgressHUD showToView:view];
    }
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD hideHUDForView:view];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success(obj,resultDesc);
        }
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes, resultCode);
    }];
}
/** 11.查询商户订单信息 */
+ (void)virtualBusiness_orderQueryView:(UIView *)view
                            parameters:(id)parameters
                               success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                               failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/order/query",requestMacros.baseUrl];
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD hideHUDForView:view];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            success(obj,resultDesc);
        }
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes, resultCode);
    }];
}
/** 12.取消订单 */
+ (void)virtualBusiness_orderCancelView:(UIView *)view
                             parameters:(id)parameters
                                success:(void (^)(NSDictionary *obj, NSString *resultDesc))success
                                failure:(void (^)(ErrorType errorType, NSString *mes, NSString *resultCode))failure {
    RequestMacros *requestMacros = [RequestMacros shareInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/v6_4/virtual/business/order/cancel",requestMacros.baseUrl];
    [MBProgressHUD showToView:view];
    [XYNetworking postWithUrlString:urlStr parameters:parameters success:^(id obj, NSString *resultDesc) {
        [MBProgressHUD showSuccess:@"取消成功" ToView:view completeBlcok:^{
            success(obj,resultDesc);
        }];
    } failure:^(ErrorType errorType, NSString *mes, NSString *resultCode) {
        [MBProgressHUD showError:mes ToView:view];
        failure(errorType, mes, resultCode);
    }];
}
@end
