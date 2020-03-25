//
//  UserModel.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/2.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject
/**
 获取单例
 @return 返回单例
 */
+ (UserModel *)sharedInstance;

/**
 刷新登录信息
 @param dic 登录dic
 */
- (void)reloadWithDic:(NSDictionary *)dic;

@property (nonatomic, strong) NSDictionary *dataDic;
/** 登录状态 */
@property (nonatomic, assign) BOOL loginState;
/** 用户account */
@property (nonatomic, copy) NSString *account;
/** 站点名称 */
@property (nonatomic, copy) NSString *stationName;
/** 站点图片 */
@property (nonatomic, copy) NSString *stationImg;
/** 营业时间 */
@property (nonatomic, copy) NSString *openingStartTimeStr;
@property (nonatomic, copy) NSString *openingEndTimeStr;
@property (nonatomic, copy) NSString *openingTimeStr;
/** 地址 */
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *countyName;
@property (nonatomic, copy) NSString *stationLocation;
@property (nonatomic, copy) NSString *address;
/** 联系电话 */
@property (nonatomic, copy) NSString *telephone;
/** 油站编码 */
@property (nonatomic, copy) NSString *stationCode;


/** sessionToken */
@property (nonatomic, copy) NSString *sessionToken;
/** accessToken */
@property (nonatomic, copy) NSString *accessToken;


- (void)signOut;

@end

NS_ASSUME_NONNULL_END
