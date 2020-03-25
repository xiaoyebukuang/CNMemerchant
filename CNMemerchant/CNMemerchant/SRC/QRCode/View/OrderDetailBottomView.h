//
//  OrderDetailBottomView.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/18.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessOrderModel.h"
#import "BaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailBottomView : UIView

- (void)reloadViewWithModel:(OrderModel *)orderModel;

@end


@interface OrderDetailBottomTableViewCell : BaseTableViewCell

- (void)reloadViewWithName:(NSString *)name content:(NSString *)content;

@end




NS_ASSUME_NONNULL_END
