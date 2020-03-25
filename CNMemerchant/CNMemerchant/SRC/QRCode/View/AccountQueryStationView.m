//
//  AccountQueryStationView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/17.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "AccountQueryStationView.h"

@interface AccountQueryStationView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIControl *backControl;
/** 选择器 */
@property (nonatomic, strong) UIPickerView *pickerView;
/** 动画时间 */
@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, assign) NSInteger selectedRow;
@end

@implementation AccountQueryStationView

+ (void)showAccountQueryStationViewWithModelArray:(NSArray *)modelArray accountQueryStationCallBlock:(AccountQueryStationCallBlock)callBlock {
    AccountQueryStationView *stationView = [[AccountQueryStationView alloc]initWithWithModelArray:modelArray accountQueryStationCallBlock:callBlock];
    [stationView prepareShow];
}
- (instancetype)initWithWithModelArray:(NSArray *)modelArray accountQueryStationCallBlock:(AccountQueryStationCallBlock)callBlock {
    self = [super init];
    if (self) {
        self.selectedRow = 0;
        self.modelArray = modelArray;
        self.callBlock = callBlock;
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.duration = 0.3;
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
    [self addSubview:self.backControl];
    self.backControl.frame = self.bounds;
    
    [self addSubview:self.contentView];
    self.contentView.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, 44 + 216 + IPHONEX_BOTTOW_HEIGHT);
    
    [self.contentView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self.contentView);
        make.top.equalTo(self.headerView.mas_bottom);
        make.height.mas_equalTo(216);
    }];
}
/** 展示view准备工作 */
- (void)prepareShow {
    [kAppDelegateWindow addSubview:self];
    self.contentView.top = MAIN_SCREEN_HEIGHT;
    [UIView animateWithDuration:self.duration animations:^{
        self.contentView.top = MAIN_SCREEN_HEIGHT - self.contentView.height;
        self.backControl.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
/** 消失 */
- (void)dismissView {
    [UIView animateWithDuration:self.duration animations:^{
        self.contentView.top = MAIN_SCREEN_HEIGHT;
        self.backControl.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark -- event
- (void)backControlEvent:(UIButton *)sender {
    [self dismissView];
}
- (void)cancelBtnEvent:(UIButton *)sender {
    [self dismissView];
}
- (void)sureBtnEvent:(UIButton *)sender {
    if (self.selectedRow < self.modelArray.count) {
        if (self.callBlock) {
            self.callBlock(self.modelArray[self.selectedRow]);
        }
    }
    [self dismissView];
}
#pragma mark - UIPickerViewDataSource&UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.modelArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return MAIN_SCREEN_WIDTH;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    ProduceListModel *model = self.modelArray[row];
    return model.oilName;
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    UILabel *pickerLabel;
//    if ([view isKindOfClass:[UILabel class]]) {
//        pickerLabel = (UILabel*)view;
//    }
//    if (!pickerLabel) {
//        pickerLabel = [[UILabel alloc]init];
//        pickerLabel.font = SYSTEM_FONT_20;
//        pickerLabel.contentMode = UIViewContentModeCenter;
//        pickerLabel.textColor = [UIColor color_333333];
//    }
//    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
//    return pickerLabel;
//}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedRow = row;
}
#pragma mark -- setup
- (UIControl *)backControl {
    if (!_backControl) {
        _backControl = [[UIControl alloc]init];
        [_backControl addTarget:self action:@selector(backControlEvent:) forControlEvents:UIControlEventTouchUpInside];
        _backControl.backgroundColor = [UIColor color_000000_4];
    }
    return _backControl;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor color_FFFFFF];
    }
    return _contentView;
}
- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerV = [[UIView alloc]init];
        UIButton *cancelBtn = [UIButton buttonWithTitle:@"取消" titleColor:[UIColor color_999999] font:SYSTEM_FONT_17];
        [cancelBtn addTarget:self action:@selector(cancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [headerV addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerV).mas_offset(Normal_Spcae);
            make.height.centerY.equalTo(headerV);
        }];
        UIButton *sureBtn = [UIButton buttonWithTitle:@"确定" titleColor:[UIColor color_333333] font:SYSTEM_FONT_17];
        [sureBtn addTarget:self action:@selector(sureBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [headerV addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerV).mas_offset(-Normal_Spcae);
            make.height.centerY.equalTo(headerV);
        }];
        UILineView *lineView = [[UILineView alloc]init];
        [headerV addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cancelBtn);
            make.right.equalTo(sureBtn);
            make.bottom.equalTo(headerV);
            make.height.mas_equalTo(0.5);
        }];
        _headerView = headerV;
    }
    return _headerView;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        UIPickerView *pickerV = [[UIPickerView alloc]init];
        pickerV.delegate = self;
        UIView *line01 = [[UIView alloc]init];
        line01.backgroundColor = [UIColor color_CDCDCD];
        UIView *line02 = [[UIView alloc]init];
        line02.backgroundColor = [UIColor color_CDCDCD];
        [pickerV addSubview:line01];
        [line01 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(pickerV);
            make.height.mas_equalTo(0.5);
            make.top.equalTo(pickerV.mas_centerY).mas_offset(-18);
        }];
        [pickerV addSubview:line02];
        [line02 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(line01);
            make.bottom.equalTo(pickerV.mas_centerY).mas_offset(18);
        }];
        _pickerView = pickerV;
    }
    return _pickerView;
}
@end
