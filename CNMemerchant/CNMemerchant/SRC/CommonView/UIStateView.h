//
//  UIStateView.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/12.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIStateView : UIView


- (instancetype)initWithTitle:(NSString *)title;

@property (nonatomic, strong) UIView *alphaView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *rightBtn;


- (void)changeAlphaWithAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
