//
//  AccountQueryStationView.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/17.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProduceListModel.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^AccountQueryStationCallBlock)(ProduceListModel *produceListModel);

@interface AccountQueryStationView : UIView

@property (nonatomic, copy) AccountQueryStationCallBlock callBlock;

+ (void)showAccountQueryStationViewWithModelArray:(NSArray *)modelArray accountQueryStationCallBlock:(AccountQueryStationCallBlock)callBlock;


@end

NS_ASSUME_NONNULL_END
