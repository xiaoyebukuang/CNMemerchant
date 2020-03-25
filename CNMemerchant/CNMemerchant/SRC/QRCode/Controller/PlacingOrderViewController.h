//
//  PlacingOrderViewController.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/18.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlacingOrderViewController : BaseMultiViewController

/** 虚拟油卡 */
@property (nonatomic, copy) NSString *virtualOilcard;
/** 虚拟油卡用户code */
@property (nonatomic, copy) NSString *userCode;



@end

NS_ASSUME_NONNULL_END
