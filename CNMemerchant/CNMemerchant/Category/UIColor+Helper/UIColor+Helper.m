//
//  UIColor+Helper.m
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/20.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIColor+Helper.h"

/** 获取颜色 */
//16进制颜色定义


@implementation UIColor (Helper)
+ (UIColor *)color_random {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
+ (UIColor *)color_hex:(NSString *)hex {
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
+ (UIColor *)color_main {
    return [UIColor color_FAFAFA];
}
+ (UIColor *)color_FFFFFF {
    UIColor *color = UIColorFromRGB(0xFFFFFF);
    return color;
}
+ (UIColor *)color_FFFFFF_3 {
    UIColor *color = COLOR_RGB_ALPHA(0xFFFFFF,0.3);
    return color;
}
+ (UIColor *)color_FFFFFF_4 {
    UIColor *color = COLOR_RGB_ALPHA(0xFFFFFF,0.4);
    return color;
}
+ (UIColor *)color_EEEEEE {
    UIColor *color = UIColorFromRGB(0xEEEEEE);
    return color;
}
+ (UIColor *)color_333333 {
    UIColor *color = UIColorFromRGB(0x333333);
    return color;
}
+ (UIColor *)color_666666 {
    UIColor *color = UIColorFromRGB(0x666666);
    return color;
}
+ (UIColor *)color_888888 {
    UIColor *color = UIColorFromRGB(0x888888);
    return color;
}
+ (UIColor *)color_999999 {
    UIColor *color = UIColorFromRGB(0x999999);
    return color;
}
+ (UIColor *)color_F7F7F7 {
    UIColor *color = UIColorFromRGB(0xF7F7F7);
    return color;
}
+ (UIColor *)color_F0F0F0 {
    UIColor *color = UIColorFromRGB(0xF0F0F0);
    return color;
}
+ (UIColor *)color_FD7E2D {
    UIColor *color = UIColorFromRGB(0xFD7E2D);
    return color;
}
+ (UIColor *)color_000000 {
    UIColor *color = UIColorFromRGB(0x000000);
    return color;
}
+ (UIColor *)color_F8F8F8 {
    UIColor *color = UIColorFromRGB(0xF8F8F8);
    return color;
}

+ (UIColor *)color_000000_1 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.1);
    return color;
}
+ (UIColor *)color_000000_4 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.4);
    return color;
}
+ (UIColor *)color_000000_5 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.5);
    return color;
}
+ (UIColor *)color_000000_8 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.8);
    return color;
}
+ (UIColor *)color_000000_15 {
    UIColor *color = COLOR_RGB_ALPHA(0x000000,0.15);
    return color;
}
+ (UIColor *)color_FF4C4C {
    UIColor *color = UIColorFromRGB(0xFF4C4C);
    return color;
}
+ (UIColor *)color_FCFCFC {
    UIColor *color = UIColorFromRGB(0xFCFCFC);
    return color;
}
+ (UIColor *)color_007AFF {
    UIColor *color = UIColorFromRGB(0x007AFF);
    return color;
}
+ (UIColor *)color_09141F {
    UIColor *color = UIColorFromRGB(0x09141F);
    return color;
}
+ (UIColor *)color_8B8B8B {
    UIColor *color = UIColorFromRGB(0x8B8B8B);
    return color;
}
+ (UIColor *)color_278CCF {
    UIColor *color = UIColorFromRGB(0x278CCF);
    return color;
}
+ (UIColor *)color_C3C3C3 {
    UIColor *color = UIColorFromRGB(0xC3C3C3);
    return color;
}
+ (UIColor *)color_C3C3C3_5 {
    UIColor *color = COLOR_RGB_ALPHA(0xC3C3C3,0.5);
    return color;
}
+ (UIColor *)color_FAFAFA {
    UIColor *color = UIColorFromRGB(0xFAFAFA);
    return color;
}
+ (UIColor *)color_FFF8CB {
    UIColor *color = UIColorFromRGB(0xFFF8CB);
    return color;
}
+ (UIColor *)color_EAEBEC {
    UIColor *color = UIColorFromRGB(0xEAEBEC);
    return color;
}
+ (UIColor *)color_212121 {
    UIColor *color = UIColorFromRGB(0x12121);
    return color;
}
+ (UIColor *)color_FD1849 {
    UIColor *color = UIColorFromRGB(0xFD1849);
    return color;
}
+ (UIColor *)color_FD7E2B {
    UIColor *color = UIColorFromRGB(0xFD7E2B);
    return color;
}
+ (UIColor *)color_232323 {
    UIColor *color = UIColorFromRGB(0x232323);
    return color;
}
+ (UIColor *)color_FEFEFE {
    UIColor *color = UIColorFromRGB(0xFEFEFE);
    return color;
}
+ (UIColor *)color_E2E2E2 {
    UIColor *color = UIColorFromRGB(0xE2E2E2);
    return color;
}
+ (UIColor *)color_808080 {
    UIColor *color = UIColorFromRGB(0x808080);
    return color;
}
+ (UIColor *)color_FF3F3F {
    UIColor *color = UIColorFromRGB(0xFF3F3F);
    return color;
}
+ (UIColor *)color_DDDDDD {
    UIColor *color = UIColorFromRGB(0xDDDDDD);
    return color;
}
+ (UIColor *)color_262626 {
    UIColor *color = UIColorFromRGB(0x262626);
    return color;
}
+ (UIColor *)color_ED2D14 {
    UIColor *color = UIColorFromRGB(0xED2D14);
    return color;
}
+ (UIColor *)color_151515 {
    UIColor *color = UIColorFromRGB(0x151515);
    return color;
}
+ (UIColor *)color_b05c1e {
    UIColor *color = UIColorFromRGB(0xb05c1e);
    return color;
}
+ (UIColor *)color_FEE6E6 {
    UIColor *color = UIColorFromRGB(0xFEE6E6);
    return color;
}
+ (UIColor *)color_E6E6E6 {
    UIColor *color = UIColorFromRGB(0xE6E6E6);
    return color;
}
+ (UIColor *)color_1E1E1E {
    UIColor *color = UIColorFromRGB(0x1E1E1E);
    return color;
}
+ (UIColor *)color_FF7E3F {
    UIColor *color = UIColorFromRGB(0xFF7E3F);
    return color;
}
+ (UIColor *)color_FF7E3F_5 {
    UIColor *color = COLOR_RGB_ALPHA(0xFF7E3F,0.5);
    return color;
}
+ (UIColor *)color_2D7BFD {
    UIColor *color = UIColorFromRGB(0x2D7BFD);
    return color;
}
+ (UIColor *)color_FFFCE8 {
    UIColor *color = UIColorFromRGB(0xFFFCE8);
    return color;
}
+ (UIColor *)color_EB5846 {
    UIColor *color = UIColorFromRGB(0xEB5846);
    return color;
}
+ (UIColor *)color_CCCCCC {
    UIColor *color = UIColorFromRGB(0xCCCCCC);
    return color;
}

+ (UIColor *)color_139EFF {
    UIColor *color = UIColorFromRGB(0x139EFF);
    return color;
}
+ (UIColor *)color_CECECE {
    UIColor *color = UIColorFromRGB(0xCECECE);
    return color;
}
+ (UIColor *)color_CECECE_32 {
    UIColor *color = COLOR_RGB_ALPHA(0xCECECE,0.32);
    return color;
}
+ (UIColor *)color_030303 {
    UIColor *color = UIColorFromRGB(0x030303);
    return color;
}
+ (UIColor *)color_FD732D {
    UIColor *color = UIColorFromRGB(0xFD732D);
    return color;
}
+ (UIColor *)color_EEF6FB {
    UIColor *color = UIColorFromRGB(0xEEF6FB);
    return color;
}
+ (UIColor *)color_CDCDCD {
    UIColor *color = UIColorFromRGB(0xCDCDCD);
    return color;
}
+ (UIColor *)color_EEEEF0 {
    UIColor *color = UIColorFromRGB(0xEEEEF0);
    return color;
}
+ (UIColor *)color_149EFF {
    UIColor *color = UIColorFromRGB(0x149EFF);
    return color;
}
+ (UIColor *)color_01C34D {
    UIColor *color = UIColorFromRGB(0x01C34D);
    return color;
}
+ (UIColor *)color_FF3F40 {
    UIColor *color = UIColorFromRGB(0xFF3F40);
    return color;
}
+ (UIColor *)color_FDFDFD {
    UIColor *color = UIColorFromRGB(0xFDFDFD);
    return color;
}
+ (UIColor *)color_FFF2EA {
    UIColor *color = UIColorFromRGB(0xFFF2EA);
    return color;
}
+ (UIColor *)color_979797 {
    UIColor *color = UIColorFromRGB(0x979797);
    return color;
}
+ (UIColor *)color_2E7BFD {
    UIColor *color = UIColorFromRGB(0x2E7BFD);
    return color;
}
+ (UIColor *)color_FFFAF1 {
    UIColor *color = UIColorFromRGB(0xFFFAF1);
    return color;
}
+ (UIColor *)color_F2F2F2 {
    UIColor *color = UIColorFromRGB(0xF2F2F2);
    return color;
}
+ (UIColor *)color_F6F6F6 {
    UIColor *color = UIColorFromRGB(0xF6F6F6);
    return color;
}
+ (UIColor *)color_454545_9 {
    UIColor *color = COLOR_RGB_ALPHA(0x454545,0.9);
    return color;
}
+ (UIColor *)color_F1974A {
    UIColor *color = UIColorFromRGB(0xF1974A);
    return color;
}
+ (UIColor *)color_E5E5E5 {
    UIColor *color = UIColorFromRGB(0xE5E5E5);
    return color;
}
+ (UIColor *)color_CBCBCB {
    UIColor *color = UIColorFromRGB(0xCBCBCB);
    return color;
}
+ (UIColor *)color_64482F {
    UIColor *color = UIColorFromRGB(0x64482F);
    return color;
}
+ (UIColor *)color_AE987C {
    UIColor *color = UIColorFromRGB(0xAE987C);
    return color;
}
+ (UIColor *)color_644830 {
    UIColor *color = UIColorFromRGB(0x644830);
    return color;
}

+ (UIColor *)color_649FF4 {
    UIColor *color = UIColorFromRGB(0x649FF4);
    return color;
}
+ (UIColor *)color_FE7B45 {
    UIColor *color = UIColorFromRGB(0xFE7B45);
    return color;
}
+ (UIColor *)color_F33C48 {
    UIColor *color = UIColorFromRGB(0xF33C48);
    return color;
}
+ (UIColor *)color_F8E8CA {
    UIColor *color = UIColorFromRGB(0xF8E8CA);
    return color;
}
+ (UIColor *)color_FEFDEB {
    UIColor *color = UIColorFromRGB(0xFEFDEB);
    return color;
}
+ (UIColor *)color_ECECEC {
    UIColor *color = UIColorFromRGB(0xECECEC);
    return color;
}
+ (UIColor *)color_F2503B {
    UIColor *color = UIColorFromRGB(0xF2503B);
    return color;
}
+ (UIColor *)color_75430E {
    UIColor *color = UIColorFromRGB(0x75430E);
    return color;
}
+ (UIColor *)color_6A6022 {
    UIColor *color = UIColorFromRGB(0x6A6022);
    return color;
}
+ (UIColor *)color_FFF8CA {
    UIColor *color = UIColorFromRGB(0xFFF8CA);
    return color;
}
+ (UIColor *)color_FFF3EB {
    UIColor *color = UIColorFromRGB(0xFFF3EB);
    return color;
}
+ (UIColor *)color_FF614D {
    UIColor *color = UIColorFromRGB(0xFF614D);
    return color;
}
+ (UIColor *)color_FEBE96 {
    UIColor *color = COLOR_RGB_ALPHA(0xFEBE96,0.5);
    return color;
}
+ (UIColor *)color_FB6472 {
    UIColor *color = UIColorFromRGB(0xFB6472);
    return color;
}
+ (UIColor *)color_DEF2FF {
    UIColor *color = UIColorFromRGB(0xDEF2FF);
    return color;
}
+ (UIColor *)color_FE5C00 {
    UIColor *color = UIColorFromRGB(0xFE5C00);
    return color;
}
+ (UIColor *)color_FFE9CB {
    UIColor *color = UIColorFromRGB(0xFFE9CB);
    return color;
}
+ (UIColor *)color_0054FF {
    UIColor *color = UIColorFromRGB(0x0054FF);
    return color;
}
+ (UIColor *)color_FFC61C {
    UIColor *color = UIColorFromRGB(0xFFC61C);
    return color;
}
+ (UIColor *)color_F6F6F8 {
    UIColor *color = UIColorFromRGB(0xF6F6F8);
    return color;
}
+ (UIColor *)color_2296FF {
    UIColor *color = UIColorFromRGB(0x2296FF);
    return color;
}



+ (UIColor *)color_FF9B0A {
    UIColor *color = UIColorFromRGB(0xFF9B0A);
    return color;
}
+ (UIColor *)color_FF630B {
    UIColor *color = UIColorFromRGB(0xFF630B);
    return color;
}
+ (UIColor *)color_FF3A30 {
    UIColor *color = UIColorFromRGB(0xFF3A30);
    return color;
}
+ (UIColor *)color_FE6B2E {
    UIColor *color = UIColorFromRGB(0xFE6B2E);
    return color;
}
@end
