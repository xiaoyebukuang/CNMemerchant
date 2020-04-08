//
//  HomeTableViewCell.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/5.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BusinessOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : BaseTableViewCell

- (void)reloadViewWithModel:(OrderModel *)orderModel isHome:(BOOL)isHome;

@end

NS_ASSUME_NONNULL_END
