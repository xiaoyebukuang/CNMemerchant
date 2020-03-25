



//
//  MineOilTypeView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/12.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "MineOilTypeView.h"
#import "CommonHeaderTableView.h"
#import "ProduceListModel.h"
@interface MineOilTypeView()

@property (nonatomic, strong) CommonHeaderTableView *commonHeaderTableView;

@property (nonatomic, strong) UIView *hootView;

@end

@implementation MineOilTypeView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.backgroundColor = [UIColor color_FFFFFF];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    [self addSubview:self.commonHeaderTableView];
    [self.commonHeaderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self);
        make.height.mas_equalTo(COMMON_CELL_HEIGHT);
    }];
    [self addSubview:self.hootView];
    [self.hootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self);
        make.top.equalTo(self.commonHeaderTableView.mas_bottom);
    }];
}
- (void)reloadViewWithDic:(NSDictionary *)dic {
    for (UIView *subView in self.hootView.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat view_height = 0;
    CGFloat view_width = MAIN_SCREEN_WIDTH - 2*Normal_Spcae;
    CGFloat content_x = Normal_Spcae;
    CGFloat content_y = 20.0f;
    CGFloat content_height = 30.0f;
    CGFloat content_hor_space = 10.0f;
    CGFloat content_ver_space = Normal_Spcae;
    NSArray *productList = dic[@"productList"];
    NSMutableArray *produceArray = [NSMutableArray array];
    if ([productList isKindOfClass:[NSArray class]]) {
        view_height = COMMON_CELL_HEIGHT;
        for (NSDictionary *subDic in productList) {
            if ([subDic isKindOfClass:[NSDictionary class]]) {
                ProduceListModel *listModel = [[ProduceListModel alloc]initWithDic:subDic];
                [produceArray addObject:listModel];
                UILabel *titleL = [[UILabel alloc]initWithText:listModel.oilName textColor:[UIColor color_333333] font:SYSTEM_FONT_14];
                titleL.textAlignment = NSTextAlignmentCenter;
                titleL.backgroundColor = [UIColor color_F6F6F8];
                titleL.layer.masksToBounds = YES;
                titleL.layer.cornerRadius = content_height/2.0;
                [self.hootView addSubview:titleL];
                CGFloat content_width = [listModel.oilName getStrWidthWithFont:SYSTEM_FONT_14] + 24;
                if (content_width + content_x + content_hor_space > view_width) {
                    content_x = Normal_Spcae;
                    content_y = content_y + content_height + content_ver_space;
                }
                titleL.frame = CGRectMake(content_x, content_y, content_width, content_height);
                content_x = content_x + content_width + content_hor_space;
                view_height = COMMON_CELL_HEIGHT + content_y + content_height + content_ver_space;
            }
        }
    }
    self.hidden = (produceArray.count == 0)?YES:NO;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(view_height);
    }];
}
#pragma mark -- setup
- (CommonHeaderTableView *)commonHeaderTableView {
    if (!_commonHeaderTableView) {
        _commonHeaderTableView = [[CommonHeaderTableView alloc]initWithImageName:@"mine_oil" title:@"提供油品"];
    }
    return _commonHeaderTableView;
}
- (UIView *)hootView {
    if (!_hootView) {
        _hootView = [[UIView alloc]init];
    }
    return _hootView;
}
@end
