//
//  LoginTableViewCell.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/4.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "LoginTableViewCell.h"

@interface LoginTableViewCell()<UITextFieldToolDelegate>
{
    dispatch_source_t _timer;
}

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextFieldTool *textFieldTool;

@property (nonatomic, strong) UIButton *codeBtn;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UILineView *lineView;



@end

@implementation LoginTableViewCell


- (void)setupUI {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).mas_offset(30);
        make.top.equalTo(self.contentView).mas_offset(Normal_Spcae);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(75);
    }];
    [self.contentView addSubview:self.textFieldTool];
    [self.textFieldTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.height.equalTo(self.titleLabel);
        make.right.equalTo(self).mas_offset(-30);
    }];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.textFieldTool);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    [self.contentView addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.height.mas_equalTo(32);
        make.width.mas_equalTo(92);
        make.right.equalTo(self.textFieldTool);
    }];
    [self.contentView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView).mas_offset(-25);
    }];
}
- (void)reloadViewWithLoginTextFieldType:(LoginTextFieldType)fieldType loginTextFieldEditBlock:(LoginTextFieldEditBlock)editBlcok {
    [self reloadViewWithLoginTextFieldType:fieldType content:@"" loginTextFieldEditBlock:editBlcok];
}
- (void)reloadViewWithLoginTextFieldType:(LoginTextFieldType)fieldType content:(NSString *)content loginTextFieldEditBlock:(LoginTextFieldEditBlock)editBlcok {
    self.editBlock = editBlcok;
    self.titleLabel.hidden = NO;
    self.codeBtn.hidden = YES;
    self.textFieldTool.text = content;
    self.textFieldTool.userInteractionEnabled = YES;
    self.arrowImageView.hidden = YES;
    CGFloat title_top = Normal_Spcae;
    CGFloat title_width = 75;
    CGFloat title_height = 50;
    CGFloat title_left = 30;
    switch (fieldType) {
        case LoginTextFieldUser:
        {
            title_width = 0;
            self.titleLabel.hidden = YES;
            self.titleLabel.text = @"";
            self.textFieldTool.fieldType = UITextFieldToolNumberCharacter;
            self.textFieldTool.maxCount = 10;
            self.textFieldTool.placeholderStr = @"请输入账号";
        }
            break;
        case LoginTextFieldPW:
        {
            title_width = 0;
            self.titleLabel.hidden = YES;
            self.titleLabel.text = @"";
            self.textFieldTool.fieldType = UITextFieldToolNumberCharacter;
            self.textFieldTool.maxCount = 15;
            self.textFieldTool.placeholderStr = @"请输入密码";
        }
            break;
        case LoginTextFieldOriginalPW:
        {
            self.titleLabel.text = @"原始密码";
            self.textFieldTool.fieldType = UITextFieldToolNumberCharacter;
            self.textFieldTool.maxCount = 15;
            self.textFieldTool.placeholderStr = @"请输入原始密码";
        }
            break;
        case LoginTextFieldOldPW:
        {
            self.titleLabel.text = @"旧密码";
            self.textFieldTool.fieldType = UITextFieldToolNumberCharacter;
            self.textFieldTool.maxCount = 15;
            self.textFieldTool.placeholderStr = @"请输入旧密码";
        }
            break;
        case LoginTextFieldNewPW:
        {
            self.titleLabel.text = @"新密码";
            self.textFieldTool.fieldType = UITextFieldToolNumberCharacter;
            self.textFieldTool.maxCount = 15;
            self.textFieldTool.placeholderStr = @"支持8-15位数字、大小写字母";
        }
            break;
        case LoginTextFieldAgainNewPW:
        {
            self.titleLabel.text = @"确认密码";
            self.textFieldTool.fieldType = UITextFieldToolNumberCharacter;
            self.textFieldTool.maxCount = 15;
            self.textFieldTool.placeholderStr = @"支持8-15位数字、大小写字母";
        }
            break;
        case LoginTextFieldTel:
        {
            self.titleLabel.text = @"手机号";
            self.textFieldTool.fieldType = UITextFieldToolNumber;
            self.textFieldTool.maxCount = 11;
            self.textFieldTool.placeholderStr = @"请输入手机号";
        }
            break;
        case LoginTextFieldCode:
        {
            title_top = 0;
            title_height = COMMON_CELL_HEIGHT;
            self.codeBtn.hidden = NO;
            self.titleLabel.text = @"验证码";
            self.textFieldTool.fieldType = UITextFieldToolNumber;
            self.textFieldTool.maxCount = 4;
            self.textFieldTool.placeholderStr = @"请输入短信验证码";
        }
            break;
        case LoginTextFieldOilType:
        {
            title_top = 0;
            title_left = Normal_Spcae;
            title_height = COMMON_CELL_HEIGHT;
            self.arrowImageView.hidden = NO;
            self.textFieldTool.userInteractionEnabled = NO;
            self.titleLabel.text = @"油品";
            self.textFieldTool.placeholderStr = @"请选择油品";
        }
            break;
        case LoginTextFieldOilQuantity:
        {
            title_top = 0;
            title_left = Normal_Spcae;
            title_height = COMMON_CELL_HEIGHT;
            self.titleLabel.text = @"加油量";
            self.textFieldTool.fieldType = UITextFieldToolDecimalPoint;
            self.textFieldTool.maxCount = 6;
            self.textFieldTool.placeholderStr = @"请输入加油升数";
        }
            break;
        case LoginTextFieldConsumptionAmount:
        {
            title_top = 0;
            title_left = Normal_Spcae;
            title_height = COMMON_CELL_HEIGHT;
            self.titleLabel.text = @"消费金额";
            self.textFieldTool.fieldType = UITextFieldToolDecimalPoint;
            self.textFieldTool.maxCount = 8;
            self.textFieldTool.placeholderStr = @"请输入客户需要支付金额";
        }
            break;
        default:
            break;
    }
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(title_width);
        make.height.mas_equalTo(title_height);
        make.top.equalTo(self.contentView).mas_offset(title_top);
        make.left.equalTo(self.contentView).mas_offset(title_left);
    }];
}
#pragma mark -- event
- (void)code_btnEvent:(UIButton *)sender {
    if (![UIJudgeTool validatePhoneNumber:self.cachePhoneNo]) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }
    [RequestMacros virtualBusiness_accountSendParameters:@{@"phoneNo":self.cachePhoneNo} success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        [self countDownGCD:30];
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        
    }];
}
- (void)countDownGCD:(NSInteger)time{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    if (time <= 0) {
        return;
    }
    self.codeBtn.enabled = NO;
    self.codeBtn.backgroundColor = [UIColor clearColor];
    [self.codeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
    }];
    [self.codeBtn setTitle:[NSString stringWithFormat:@"(%ldS)后重新发送",(long)time] forState:UIControlStateNormal];
    __block NSInteger timeout = time; //倒计时时间
    __weak typeof(self)weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 1.0*NSEC_PER_SEC),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        timeout--;
        NSString *title = [NSString stringWithFormat:@"(%ldS)后重新发送",(long)timeout];
        if(timeout <=0 ){
            title = @"获取验证码";
            //倒计时结束，关闭
            dispatch_source_cancel(self->_timer);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置
            if (timeout <= 0) {
                weakSelf.codeBtn.enabled = YES;
                weakSelf.codeBtn.backgroundColor = [UIColor color_FFC61C];
                [weakSelf.codeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(92);
                }];
            }
            [weakSelf.codeBtn setTitle:title forState:UIControlStateNormal];
        });
    });
    dispatch_resume(_timer);
}
#pragma mark -- UITextFieldToolDelegate
- (void)textChange:(NSString *)text textViewTool:(UITextFieldTool *)textFieldTool {
    if (self.editBlock) {
        self.editBlock(text);
    }
}
#pragma mark -- setup
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithTextColor:[UIColor color_333333] font:SYSTEM_FONT_14];
    }
    return _titleLabel;
}
- (UITextFieldTool *)textFieldTool {
    if (!_textFieldTool) {
        _textFieldTool = [[UITextFieldTool alloc]initWithType:UITextFieldToolNumber];
        _textFieldTool.tool_delegate = self;
    }
    return _textFieldTool;
}
- (UILineView *)lineView {
    if (!_lineView) {
        _lineView = [[UILineView alloc]init];
    }
    return _lineView;
}
- (UIButton *)codeBtn {
    if (!_codeBtn) {
        _codeBtn = [UIButton buttonWithTitle:@"获取验证码" font:SYSTEM_FONT_14 normalColor:[UIColor color_FFFFFF] disabledColor:[UIColor color_999999]];
        _codeBtn.layer.masksToBounds = YES;
        _codeBtn.layer.cornerRadius = 16;
        _codeBtn.backgroundColor = [UIColor color_FFC61C];
        [_codeBtn addTarget:self action:@selector(code_btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeBtn;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"write_off_arrow"]];
        _arrowImageView.hidden = YES;
    }
    return _arrowImageView;
}
@end
