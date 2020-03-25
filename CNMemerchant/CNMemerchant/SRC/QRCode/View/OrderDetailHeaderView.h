//
//  OrderDetailHeaderView.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/18.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol OrderDetailHeaderViewDelegate <NSObject>

- (void)needToReloadView;

@end

@interface OrderDetailHeaderView : UIView


@property (nonatomic, weak) id<OrderDetailHeaderViewDelegate>delegate;

- (void)reloadViewWithModel:(OrderModel *)orderModel;


@end

NS_ASSUME_NONNULL_END
