//
//  UIRadianLayerView.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/5.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "UIRadianLayerView.h"

//圆弧方向
typedef NS_ENUM(NSInteger, RadianDirection) {
    RadianDirectionBottom     = 0,
    RadianDirectionTop        = 1,
    RadianDirectionLeft       = 2,
    RadianDirectionRight      = 3,
};

@interface UIRadianLayerView()

// 圆弧方向, 默认在下方
@property (nonatomic) RadianDirection direction;
// 圆弧高/宽, 可为负值。 正值凸, 负值凹
@property (nonatomic) CGFloat radian;
// 高度
@property (nonatomic) CGFloat radianHeight;


@end

@implementation UIRadianLayerView

- (instancetype)initWithHieght:(CGFloat)radianHeight {
    self = [super init];
    if (self) {
        self.radianHeight = radianHeight;
        self.direction = RadianDirectionBottom;
        [self setRadian:30];
    }
    return self;
}
- (void)setRadian:(CGFloat) radian{
    if (radian == 0) {
        return;
    }
    CGFloat t_width = MAIN_SCREEN_WIDTH; // 宽
    CGFloat t_height = self.radianHeight; // 高
    CGFloat height = fabs(radian); // 圆弧高度
    CGFloat x = 0;
    CGFloat y = 0;
    // 计算圆弧的最大高度
    CGFloat _maxRadian = 0;
    switch (self.direction) {
        case RadianDirectionBottom:
        case RadianDirectionTop:
            _maxRadian =  MIN(t_height, t_width / 2);
            break;
        case RadianDirectionLeft:
        case RadianDirectionRight:
            _maxRadian =  MIN(t_height / 2, t_width);
            break;
        default:
            break;
    }
    if(height > _maxRadian){
        NSLog(@"圆弧半径过大, 跳过设置。");
        return;
    }
    // 计算半径
    CGFloat radius = 0;
    switch (self.direction) {
        case RadianDirectionBottom:
        case RadianDirectionTop:
        {
            CGFloat c = sqrt(pow(t_width / 2, 2) + pow(height, 2));
            CGFloat sin_bc = height / c;
            radius = c / ( sin_bc * 2);
        }
            break;
        case RadianDirectionLeft:
        case RadianDirectionRight:
        {
            CGFloat c = sqrt(pow(t_height / 2, 2) + pow(height, 2));
            CGFloat sin_bc = height / c;
            radius = c / ( sin_bc * 2);
        }
            break;
        default:
            break;
    }
    // 画圆
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    CGMutablePathRef path = CGPathCreateMutable();
    switch (self.direction) {
        case RadianDirectionBottom:
        {
            if(radian > 0){
                CGPathMoveToPoint(path,NULL, t_width,t_height - height);
                CGPathAddArc(path,NULL, t_width / 2, t_height - radius, radius, asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), NO);
            }else{
                CGPathMoveToPoint(path,NULL, t_width,t_height);
                CGPathAddArc(path,NULL, t_width / 2, t_height + radius - height, radius, 2 * M_PI - asin((radius - height ) / radius), M_PI + asin((radius - height ) / radius), YES);
            }
            CGPathAddLineToPoint(path,NULL, x, y);
            CGPathAddLineToPoint(path,NULL, t_width, y);
        }
            break;
        case RadianDirectionTop:
        {
            if(radian > 0){
                CGPathMoveToPoint(path,NULL, t_width, height);
                CGPathAddArc(path,NULL, t_width / 2, radius, radius, 2 * M_PI - asin((radius - height ) / radius), M_PI + asin((radius - height ) / radius), YES);
            }else{
                CGPathMoveToPoint(path,NULL, t_width, y);
                CGPathAddArc(path,NULL, t_width / 2, height - radius, radius, asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), NO);
            }
            CGPathAddLineToPoint(path,NULL, x, t_height);
            CGPathAddLineToPoint(path,NULL, t_width, t_height);
        }
            break;
        case RadianDirectionLeft:
        {
            if(radian > 0){
                CGPathMoveToPoint(path,NULL, height, y);
                CGPathAddArc(path,NULL, radius, t_height / 2, radius, M_PI + asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), YES);
            }else{
                CGPathMoveToPoint(path,NULL, x, y);
                CGPathAddArc(path,NULL, height - radius, t_height / 2, radius, 2 * M_PI - asin((radius - height ) / radius), asin((radius - height ) / radius), NO);
            }
            CGPathAddLineToPoint(path,NULL, t_width, t_height);
            CGPathAddLineToPoint(path,NULL, t_width, y);
        }
            break;
        case RadianDirectionRight:
        {
            if(radian > 0){
                CGPathMoveToPoint(path,NULL, t_width - height, y);
                CGPathAddArc(path,NULL, t_width - radius, t_height / 2, radius, 1.5 * M_PI + asin((radius - height ) / radius), M_PI / 2 + asin((radius - height ) / radius), NO);
            }else{
                CGPathMoveToPoint(path,NULL, t_width, y);
                CGPathAddArc(path,NULL, t_width  + radius - height, t_height / 2, radius, M_PI + asin((radius - height ) / radius), M_PI - asin((radius - height ) / radius), YES);
            }
            CGPathAddLineToPoint(path,NULL, x, t_height);
            CGPathAddLineToPoint(path,NULL, x, y);
        }
            break;
        default:
            break;
    }
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    self.layer.mask = shapeLayer;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor color_FF9B0A].CGColor, (__bridge id)[UIColor color_FF630B].CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, t_width, t_height);
    [self.layer addSublayer:gradientLayer];
    
}

@end
