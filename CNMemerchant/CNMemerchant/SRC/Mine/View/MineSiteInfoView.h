//
//  MineSiteInfoView.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineSiteInfoView : UIView

@end


@interface MineSiteInfoTableViewCell : BaseTableViewCell

- (void)reloadViewWithTitle:(NSString *)title content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
