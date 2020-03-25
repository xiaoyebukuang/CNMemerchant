//
//  QRViewController.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/9.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "QRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlacingOrderViewController.h"
@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>
@property (strong, nonatomic) AVCaptureDevice * device;
@property (strong, nonatomic) AVCaptureDeviceInput * input;
@property (strong, nonatomic) AVCaptureMetadataOutput * output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer * preview;

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIView *qrView;

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *wgImageV;
@property (strong, nonatomic) UILabel *desLabel;
@property (nonatomic, strong) NSString     *identifier;

@property (nonatomic, assign) BOOL isRuning;
@end

@implementation QRViewController

- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
    CGFloat y = (width - CGRectGetWidth(rect)) / 2 / width;
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    return CGRectMake(x, y, w, h);
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopScan];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIJudgeTool checkCameraAuthorizationStatus:^(BOOL handler) {
        if (handler) {
            [self starScan];
        }
    }];
}
/** 开始扫描 */
- (void)starScan{
    if (self.device == nil) {
        [UIAlertViewTool showTitle:@"提示" message:@"未检测到摄像头！" titlesArr:@[@"确认"] alertBlock:^(NSString *mes, NSInteger index) {
        }];
        return;
    }
    [self.qrView insertSubview:self.wgImageV atIndex:0];
    self.wgImageV.frame = CGRectMake(0, -self.qrView.height, self.qrView.width, self.qrView.height);
    [self.session startRunning];
    self.isRuning = YES;
    [self startAnimation];
}
//控制扫描线上下滚动
- (void)startAnimation{
    if (!self.isRuning) {
        return;
    }
    self.wgImageV.bottom = 0;
    self.wgImageV.alpha = 1;
    [UIView animateWithDuration:2.7 animations:^{
        self.wgImageV.bottom = self.qrView.height;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.wgImageV.alpha = 0;
        } completion:^(BOOL finished) {
            [self startAnimation];
        }];
    }];
}
/** 暂定扫描 */
- (void)stopScan{
    self.isRuning = NO;
    [self.session stopRunning];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self scanSetup];
}
- (void)setupUI {
    [self.view addSubview:self.backView];
    [self.view addSubview:self.qrView];
    [self.view addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.qrView.mas_bottom).mas_offset(20);
    }];
}
//初始化扫描配置
- (void)scanSetup{
    self.preview.frame = self.view.bounds;
    self.preview.videoGravity = AVLayerVideoGravityResize;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode]];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        if ([metadataObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            NSString *stringValue = [metadataObject stringValue];
            stringValue = [NSString safe_string:stringValue];
            if (stringValue.length > 0) {
                [self stopScan];
                [self virtualRecharge_oilcardScanInfoWithOrderNo:stringValue];
            }
        }
    }
}
- (void)virtualRecharge_oilcardScanInfoWithOrderNo:(NSString *)orderNo {
    [RequestMacros virtualRecharge_oilcardScanInfoView:self.view parameters:@{@"orderNo":orderNo} success:^(NSDictionary * _Nonnull obj, NSString * _Nonnull resultDesc) {
        NSString *virtualOilcard = [NSString safe_string:obj[@"virtualOilcard"]];
        NSString *userCode = [NSString safe_string:obj[@"userCode"]];
        PlacingOrderViewController *placingOrderVC = [[PlacingOrderViewController alloc]init];
        placingOrderVC.virtualOilcard = virtualOilcard;
        placingOrderVC.userCode = userCode;
        [self.navigationController pushViewController:placingOrderVC animated:YES];
    } failure:^(ErrorType errorType, NSString * _Nonnull mes, NSString * _Nonnull resultCode) {
        [self starScan];
    }];
}
#pragma mark -- setup
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:self.view.bounds];
        CAShapeLayer* cropLayer = [[CAShapeLayer alloc] init];
        [_backView.layer addSublayer:cropLayer];
        // 创建一个绘制路径
        CGMutablePathRef path = CGPathCreateMutable();
        // 空心矩形的rect
        CGRect cropRect = self.qrView.frame;
        // 绘制rect
        CGPathAddRect(path, nil, _backView.bounds);
        CGPathAddRect(path, nil, cropRect);
        // 设置填充规则(重点)
        [cropLayer setFillRule:kCAFillRuleEvenOdd];
        // 关联绘制的path
        [cropLayer setPath:path];
        // 设置填充的颜色
        [cropLayer setFillColor:[[UIColor color_000000_4] CGColor]];
    }
    return _backView;
}
- (UIView *)qrView {
    if (!_qrView) {
        UIView *qrv = [[UIView alloc]init];
        qrv.clipsToBounds = YES;
        CGFloat image_v_left = 60;
        CGFloat image_v_size = MAIN_SCREEN_WIDTH -2*image_v_left;
        CGFloat image_v_top = (MAIN_SCREEN_HEIGHT - TAB_BAR_HEIGHT - image_v_size)/2 - 40;
        qrv.frame = CGRectMake(image_v_left, image_v_top, image_v_size, image_v_size);
        [qrv addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(qrv);
        }];
        _qrView = qrv;
    }
    return _qrView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qr_code_logo"]];
    }
    return _imageView;
}
- (UIImageView *)wgImageV {
    if (!_wgImageV) {
        _wgImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qr_code_wg"]];
    }
    return _wgImageV;
}
- (UILabel *)desLabel {
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]initWithText:@"将储蓄油卡二维码放入方框中扫描" textColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_16];
    }
    return _desLabel;
}
- (AVCaptureDevice *)device{
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}
- (AVCaptureDeviceInput *)input{
    if (!_input) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}
- (AVCaptureMetadataOutput *)output{
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //限制扫描区域(上下左右)
        [_output setRectOfInterest:[self rectOfInterestByScanViewRect:self.qrView.frame]];
    }
    return _output;
}
- (AVCaptureSession *)session{
    if (!_session) {
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
        }
    }
    return _session;
}
- (AVCaptureVideoPreviewLayer *)preview{
    if (!_preview) {
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _preview;
}

@end
