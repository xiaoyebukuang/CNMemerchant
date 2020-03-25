//
//  HomeStateTableViewCell.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/16.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BusinessOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeStateTableViewCell : BaseTableViewCell

- (void)reloadViewWithHomeState:(HomeState)homeState isAll:(BOOL)isAll homeStateBlock:(void(^)(void))homeStateBlock;

@end


NS_ASSUME_NONNULL_END
