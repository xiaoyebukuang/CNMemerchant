//
//  ProduceListModel.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/17.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "ProduceListModel.h"

@implementation ProduceListModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.oilName = [NSString safe_string:dic[@"oilName"]];
        self.stationCode = [NSString safe_string:dic[@"stationCode"]];
        self.oilCode = [NSString safe_string:dic[@"oilCode"]];
    }
    return self;
}

@end
