//
//  HomeOrderView.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/5.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol HomeOrderViewDelegate <NSObject>

- (void)gotoOrderListVC;

@end


@interface HomeOrderView : UIView

@property (nonatomic, weak) id<HomeOrderViewDelegate>delegate;

- (void)initializationView;

- (void)reloadViewWithDataDic:(NSDictionary *)dataDic;

@end


@interface HomeOrderChildView : UIView

@property (nonatomic, strong) UILabel *valueLabel;

@property (nonatomic, strong) UILabel *keyLabel;

- (instancetype)initWithTitle:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
