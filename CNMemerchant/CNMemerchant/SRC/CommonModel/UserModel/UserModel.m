//
//  UserModel.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/2.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "UserModel.h"
#import "AppDelegate.h"
@implementation UserModel
+ (UserModel *)sharedInstance {
    static UserModel *instance;
    UserModel *strongInstance = instance;
    @synchronized(self) {
        if (strongInstance == nil) {
            strongInstance = [[[self class] alloc] init];
            instance = strongInstance;
        }
    }
    return strongInstance;
}
/** 登录状态 */
- (void)setLoginState:(BOOL)loginState {
    [[NSUserDefaults standardUserDefaults]setBool:loginState forKey:USERDEFAULTS_USER_LOGINSTATE];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (BOOL)loginState {
    BOOL login = [[NSUserDefaults standardUserDefaults]boolForKey:USERDEFAULTS_USER_LOGINSTATE];
    return login;
}
- (NSDictionary *)dataDic {
    if (_dataDic.allKeys.count > 0) {
        return _dataDic;
    }
    NSDictionary *dataDic = [[NSUserDefaults standardUserDefaults]objectForKey:USERDEFAULTS_USER_DATA];
    return dataDic;
}
/** 用户account */
- (NSString *)account {
    return [NSString safe_string:self.dataDic[@"account"]];
}
- (NSString *)stationName {
    return [NSString safe_string:self.dataDic[@"stationName"]];
}
- (NSString *)stationImg {
    return [NSString safe_string:self.dataDic[@"stationImg"]];
}
- (NSString *)openingTimeStr {
    NSString *openingStartTimeStr = [NSString safe_string:self.dataDic[@"openingStartTimeStr"]];
    NSString *openingEndTimeStr = [NSString safe_string:self.dataDic[@"openingEndTimeStr"]];
    return [NSString stringWithFormat:@"%@-%@",openingStartTimeStr,openingEndTimeStr];
}
- (NSString *)address {
    NSString *provinceName = [NSString safe_string:self.dataDic[@"provinceName"]];
    NSString *cityName = [NSString safe_string:self.dataDic[@"cityName"]];
    NSString *countyName = [NSString safe_string:self.dataDic[@"countyName"]];
    NSString *stationLocation = [NSString safe_string:self.dataDic[@"stationLocation"]];
    return [NSString stringWithFormat:@"%@%@%@%@",provinceName,cityName,countyName,stationLocation];
}
- (NSString *)telephone {
    return [NSString safe_string:self.dataDic[@"telephone"]];
}
- (NSString *)contactNumber {
    return [NSString safe_string:self.dataDic[@"contactNumber"]];
}
- (NSString *)stationCode {
    return [NSString safe_string:self.dataDic[@"stationCode"]];
}
- (NSString *)sessionToken {
    return [NSString safe_string:self.dataDic[@"sessionToken"]];
}
- (NSString *)accessToken {
    return [NSString safe_string:self.dataDic[@"accessToken"]];
}
- (void)reloadWithDic:(NSDictionary *)dic {
    self.loginState =   YES;
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]init];
    for (NSString *key in dic.allKeys) {
        NSString *value = [NSString safe_string:dic[key]];
        [dataDic setValue:value forKey:key];
    }
    self.dataDic = dataDic;
    [[NSUserDefaults standardUserDefaults]setObject:dataDic forKey:USERDEFAULTS_USER_DATA];
    [[NSUserDefaults standardUserDefaults]synchronize];
    AppDelegate *appd = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appd setRootViewControoler];
}
- (void)signOut {
    self.loginState =   NO;
    self.dataDic = [[NSDictionary alloc]init];
    [[NSUserDefaults standardUserDefaults]setObject:@{} forKey:USERDEFAULTS_USER_DATA];
    [[NSUserDefaults standardUserDefaults]synchronize];
    AppDelegate *appd = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appd setRootViewControoler];
}
@end
