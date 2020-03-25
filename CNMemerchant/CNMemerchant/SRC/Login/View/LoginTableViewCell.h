//
//  LoginTableViewCell.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/4.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseTableViewCell.h"

//TODO:请求环境
typedef NS_ENUM(NSInteger, LoginTextFieldType) {
    LoginTextFieldUser,             //账号
    LoginTextFieldPW,               //密码
    LoginTextFieldOriginalPW,       //原始密码
    LoginTextFieldOldPW,            //旧密码
    LoginTextFieldNewPW,            //新密码
    LoginTextFieldAgainNewPW,       //确认密码
    LoginTextFieldTel,              //手机号
    LoginTextFieldCode,             //验证码
    LoginTextFieldOilType,          //油品
    LoginTextFieldOilQuantity,      //加油量
    LoginTextFieldConsumptionAmount,//消费金额
};

typedef void(^LoginTextFieldEditBlock)(NSString * _Nullable title);

NS_ASSUME_NONNULL_BEGIN

@interface LoginTableViewCell : BaseTableViewCell

@property (nonatomic, copy) LoginTextFieldEditBlock editBlock;

/** 缓存的电话 */
@property (nonatomic, copy) NSString *cachePhoneNo;

- (void)reloadViewWithLoginTextFieldType:(LoginTextFieldType)fieldType loginTextFieldEditBlock:(LoginTextFieldEditBlock)editBlcok;

- (void)reloadViewWithLoginTextFieldType:(LoginTextFieldType)fieldType content:(NSString *)content loginTextFieldEditBlock:(LoginTextFieldEditBlock)editBlcok;

@end

NS_ASSUME_NONNULL_END
