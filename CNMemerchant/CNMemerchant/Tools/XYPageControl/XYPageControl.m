//
//  XYPageControl.m
//  cwz51
//
//  Created by 陈晓 on 2018/12/22.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "XYPageControl.h"

@interface XYPageControl()

@property (nonatomic, strong) UIView *pageView;
/** 当前选中的宽度 */
@property (nonatomic, assign) CGFloat currentWidth;
/** 当前选中的高度 */
@property (nonatomic, assign) CGFloat currentHeight;
/** 默认的宽度 */
@property (nonatomic, assign) CGFloat normalWidth;
/** 间隙 */
@property (nonatomic, assign) CGFloat space;

@end

@implementation XYPageControl


- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self.pageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo((self.numberOfPages-1)*(self.normalWidth + self.space) + self.currentWidth);
        make.centerX.bottom.equalTo(self);
        make.height.mas_equalTo(self.currentHeight);
    }];
    [self setNeedsLayout];
}
- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage == currentPage) {
        return;
    }
    _currentPage = currentPage;
    [self setNeedsLayout];
}
- (void)setupUI {
    self.currentWidth = 12;
    self.normalWidth = 6;
    self.currentHeight = 5;
    self.space = 5;
    self.pageIndicatorTintColor = [UIColor color_E6E6E6];
    self.currentPageIndicatorTintColor = [UIColor color_FD7E2D];
    [self addSubview:self.pageView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in self.pageView.subviews) {
        [subView removeFromSuperview];
    }
    UIView *temp;
    for (int i = 0; i < self.numberOfPages; i ++) {
        UIView *pageChildV = [[UIView alloc]init];
        pageChildV.layer.masksToBounds = YES;
        pageChildV.layer.cornerRadius = self.currentHeight/2;
        pageChildV.backgroundColor = self.currentPage == i ? self.currentPageIndicatorTintColor:self.pageIndicatorTintColor;
        [self.pageView addSubview:pageChildV];
        if (!temp) {
            [pageChildV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.height.equalTo(self.pageView);
                make.width.mas_equalTo(self.currentPage == i ? self.currentWidth:self.normalWidth);
            }];
        } else {
            [pageChildV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.height.equalTo(self.pageView);
                make.left.equalTo(temp.mas_right).mas_offset(self.space);
                make.width.mas_equalTo(self.currentPage == i ? self.currentWidth:self.normalWidth);
            }];
        }
        temp = pageChildV;
    }
}
#pragma mark -- setup

- (UIView *)pageView {
    if (!_pageView) {
        _pageView = [[UIView alloc]init];
    }
    return _pageView;
}


@end
