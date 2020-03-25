//
//  UIAlertFieldView.m
//  cwz51
//
//  Created by 陈晓 on 2019/1/18.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import "UIAlertFieldView.h"
#import "GTMBase64.h"
/** 弹窗宽度 */
const static CGFloat kUIAlertFieldViewWidth              = 280;
/** 弹窗高度 */
const static CGFloat kUIAlertFieldViewHeight             = 220;


//输入框确定取消回调
typedef void(^UIAlertFieldCallBack)(NSString* mes, NSInteger index);
//选择框确定取消回调
typedef void(^UIAlertSureCallBack)(NSInteger index);

@interface UIAlertFieldView()
/** 类型 */
@property (nonatomic, assign) UIAlertFieldType alertFieldType;
/** 黑色遮罩 */
@property (nonatomic, strong) UIView *backView;
/** 主视图 */
@property (nonatomic, strong) UIView *dialogView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

/** 内容 */
@property (nonatomic, strong) UILabel *contentLabel;

/** 按钮 */
@property (nonatomic, strong) UIView *btnView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, assign) CGFloat btnV_height;
@property (nonatomic, assign) CGFloat btnV_width;


@property (nonatomic, copy) NSString *leftStr;
@property (nonatomic, copy) NSString *rightStr;

@property (nonatomic, copy) UIAlertSureCallBack sureCallBack;


@property (nonatomic, assign) BOOL isShow;

@end

@implementation UIAlertFieldView

- (instancetype)initWithAlertFieldType:(UIAlertFieldType)alertFieldType {
    return [self initWithAlertFieldType:alertFieldType leftStr:@"取消" rightStr:@"确定" phone:@""];
}
- (instancetype)initWithAlertFieldType:(UIAlertFieldType)alertFieldType leftStr:(NSString *)leftStr rightStr:(NSString *)rightStr {
    return [self initWithAlertFieldType:alertFieldType leftStr:leftStr rightStr:rightStr phone:@""];
}
- (instancetype)initWithAlertFieldType:(UIAlertFieldType)alertFieldType leftStr:(NSString *)leftStr rightStr:(NSString *)rightStr phone:(NSString *)phone {
    self = [super init];
    if (self) {
        self.leftStr = leftStr;
        self.rightStr = rightStr;
        [self setupMainView];
        switch (alertFieldType) {
            case UIAlertFieldTypeSure:
            {
                [self setupSureAlertUI];
            }
                break;
            default:
                break;
        }
        self.alertFieldType = alertFieldType;
    }
    return self;
}
- (void)setupMainView {
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT);
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backView];
    self.backView.frame = self.bounds;
    [self addSubview:self.dialogView];
    self.dialogView.frame = CGRectMake((self.width - WIDTH_ADAPTER(kUIAlertFieldViewWidth))/2, (MAIN_SCREEN_HEIGHT - kUIAlertFieldViewHeight)/2, WIDTH_ADAPTER(kUIAlertFieldViewWidth), kUIAlertFieldViewHeight);
    
    self.btnV_height = 40;
    self.btnV_width = (self.dialogView.width - 3*Normal_Spcae)/2;
    //标题
    [self.dialogView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dialogView);
        make.height.mas_equalTo(20);
        make.top.equalTo(self.dialogView).mas_offset(20);
    }];
    //按钮
    [self.dialogView addSubview:self.btnView];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.equalTo(self.dialogView);
        make.bottom.equalTo(self.dialogView).mas_offset(-25);
        make.height.mas_equalTo(self.btnV_height);
    }];
}
/** 选择框 */
- (void)setupSureAlertUI {
    [self.dialogView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dialogView);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.bottom.equalTo(self.btnView.mas_top).mas_offset(-5);
        make.left.equalTo(self.dialogView).mas_offset(Normal_Spcae);
    }];
}
#pragma mark -- set
- (void)setAlertFieldType:(UIAlertFieldType)alertFieldType {
    _alertFieldType = alertFieldType;
    switch (alertFieldType) {
        case UIAlertFieldTypeSure:
        {
            self.titleLabel.text = @"";
        }
            break;
        default:
            break;
    }
}
#pragma mark -- event
//左侧按钮点击
- (void)cancelBtnEvent:(UIButton *)sender {
    if (self.sureCallBack) {
        self.sureCallBack(0);
    }
    [self dismiss];
}
//右侧按钮点击
- (void)sureBtnEvent:(UIButton *)sender {
    if (self.sureCallBack) {
        self.sureCallBack(1);
    }
    [self dismiss];
}
//TODO:展示
//选择框
- (void)showAlertSureWithTitle:(NSString *)title callBack:(void(^)(NSInteger index))alertCallBlock {
    self.sureCallBack = alertCallBlock;
    self.contentLabel.text = title;
    [self showAnimation];
}
/** 开始动画 */
- (void)showAnimation {
    [kAppDelegateWindow addSubview:self];
    self.dialogView.layer.opacity = 0.5f;
    self.dialogView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.3f, 1.3f);
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.isShow = YES;
        self.dialogView.layer.opacity = 1.0f;
        self.dialogView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        self.backView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)dismiss {
    self.isShow = NO;
    [self removeFromSuperview];
}
#pragma mark -- setup
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor color_000000_4];
    }
    return _backView;
}
- (UIView *)dialogView {
    if (!_dialogView) {
        _dialogView = [[UIView alloc]init];
        _dialogView.backgroundColor = [UIColor color_FFFFFF];
        _dialogView.layer.masksToBounds = YES;
        _dialogView.layer.cornerRadius = 10;
    }
    return _dialogView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_18];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_14];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
- (UIView *)btnView {
    if (!_btnView) {
        UIView *btnV = [[UIView alloc]init];
        [btnV addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.equalTo(btnV);
            make.left.equalTo(btnV).mas_equalTo(Normal_Spcae);
            make.width.mas_equalTo(self.btnV_width);
            make.height.mas_equalTo(self.btnV_width);
        }];
        [btnV addSubview:self.sureBtn];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.equalTo(btnV);
            make.right.equalTo(btnV).mas_equalTo(-Normal_Spcae);
            make.width.mas_equalTo(self.btnV_width);
            make.height.mas_equalTo(self.btnV_width);
        }];
        _btnView = btnV;
    }
    return _btnView;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithTitle:self.leftStr titleColor:[UIColor color_FD7E2D] font:SYSTEM_FONT_15];
        _cancelBtn.backgroundColor = [UIColor color_FFFFFF];
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.cornerRadius = self.btnV_height/2;
        _cancelBtn.layer.borderWidth = 1;
        _cancelBtn.layer.borderColor = [UIColor color_FD7E2D].CGColor;
        [_cancelBtn addTarget:self action:@selector(cancelBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithTitle:self.rightStr titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_15];
        _sureBtn.backgroundColor = [UIColor color_FD7E2D];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = self.btnV_height/2;
        [_sureBtn addTarget:self action:@selector(sureBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end
