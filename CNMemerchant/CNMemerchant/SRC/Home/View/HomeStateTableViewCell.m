

//
//  HomeStateTableViewCell.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/16.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "HomeStateTableViewCell.h"


@interface HomeStateTableViewCell()

@property (nonatomic, strong) UIView *infoView;

@end

@implementation HomeStateTableViewCell

- (void)setupUI {
    [super setupUI];
    self.contentView.backgroundColor = [UIColor color_FAFAFA];
    [self.contentView addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.contentView);
        make.top.equalTo(self.contentView).mas_offset(80);
        make.height.mas_equalTo(300);
        make.bottom.equalTo(self.contentView);
    }];
}
- (void)reloadViewWithHomeState:(HomeState)homeState isAll:(BOOL)isAll homeStateBlock:(void(^)(void))homeStateBlock {
    [CommonInfoView removeInfoViewFromSuperView:self.infoView];
    if (homeState == HomeStateNoData) {
        if (isAll) {
            [CommonInfoView showInfoViewSuperView:self.infoView commonInfoType:CommonInfoHomeAllNoData];
        } else {
            [CommonInfoView showInfoViewSuperView:self.infoView commonInfoType:CommonInfoHomeNoData];
        }
    }
    if (homeState == HomeStateRequestFailed) {
        [CommonInfoView showInfoViewSuperView:self.infoView commonInfoType:CommonInfoNetworkNone commonInfoBlock:^(CommonInfoView *infoView) {
            homeStateBlock();
        }];
    }
}
#pragma mark -- setup
- (UIView *)infoView {
    if (!_infoView) {
        _infoView = [[UIView alloc]init];
    }
    return _infoView;
}
@end
