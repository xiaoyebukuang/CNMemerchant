//
//  ProduceListModel.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/17.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProduceListModel : NSObject


@property (nonatomic, copy) NSString *oilName;

@property (nonatomic, copy) NSString *stationCode;

@property (nonatomic, copy) NSString *oilCode;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
