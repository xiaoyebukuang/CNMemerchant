//
//  UIColor+Helper.h
//  qingsonghuan
//
//  Created by 陈晓 on 2018/9/20.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_RGB_ALPHA(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]
//rgb颜色
#define RGB(r,g,b)                  RGBA(r,g,b,1.0f)
#define RGBA(r,g,b,a)               [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface UIColor (Helper)

+ (UIColor *)color_hex:(NSString *)hex;

+ (UIColor *)color_random;

+ (UIColor *)color_main;

+ (UIColor *)color_FFFFFF;

+ (UIColor *)color_FFFFFF_3;

+ (UIColor *)color_FFFFFF_4;

+ (UIColor *)color_EEEEEE;

+ (UIColor *)color_333333;

+ (UIColor *)color_666666;

+ (UIColor *)color_888888;

+ (UIColor *)color_999999;

+ (UIColor *)color_F7F7F7;

+ (UIColor *)color_F0F0F0;

+ (UIColor *)color_FD7E2D;

+ (UIColor *)color_000000;

+ (UIColor *)color_F8F8F8;

+ (UIColor *)color_000000_1;

+ (UIColor *)color_000000_4;

+ (UIColor *)color_000000_5;

+ (UIColor *)color_000000_8;

+ (UIColor *)color_000000_15;

+ (UIColor *)color_FF4C4C;

+ (UIColor *)color_FCFCFC;

+ (UIColor *)color_007AFF;

+ (UIColor *)color_09141F;

+ (UIColor *)color_8B8B8B;

+ (UIColor *)color_278CCF;

+ (UIColor *)color_C3C3C3;

+ (UIColor *)color_C3C3C3_5;

+ (UIColor *)color_FAFAFA;

+ (UIColor *)color_FFF8CB;

+ (UIColor *)color_EAEBEC;

+ (UIColor *)color_212121;

+ (UIColor *)color_FD1849;

+ (UIColor *)color_FD7E2B;

+ (UIColor *)color_232323;

+ (UIColor *)color_FEFEFE;

+ (UIColor *)color_E2E2E2;

+ (UIColor *)color_808080;

+ (UIColor *)color_FF3F3F;

+ (UIColor *)color_DDDDDD;

+ (UIColor *)color_262626;

+ (UIColor *)color_ED2D14;

+ (UIColor *)color_151515;

+ (UIColor *)color_b05c1e;

+ (UIColor *)color_FEE6E6;

+ (UIColor *)color_E6E6E6;

+ (UIColor *)color_1E1E1E;

+ (UIColor *)color_FF7E3F;

+ (UIColor *)color_FF7E3F_5;

+ (UIColor *)color_2D7BFD;

+ (UIColor *)color_FFFCE8;

+ (UIColor *)color_EB5846;

+ (UIColor *)color_CCCCCC;

+ (UIColor *)color_139EFF;

+ (UIColor *)color_CECECE;

+ (UIColor *)color_CECECE_32;

+ (UIColor *)color_030303;

+ (UIColor *)color_FD732D;

+ (UIColor *)color_EEF6FB;

+ (UIColor *)color_CDCDCD;

+ (UIColor *)color_EEEEF0;

+ (UIColor *)color_149EFF;

+ (UIColor *)color_01C34D;

+ (UIColor *)color_FF3F40;

+ (UIColor *)color_FDFDFD;

+ (UIColor *)color_FFF2EA;

+ (UIColor *)color_979797;

+ (UIColor *)color_2E7BFD;

+ (UIColor *)color_FFFAF1;

+ (UIColor *)color_F2F2F2;

+ (UIColor *)color_F6F6F6;

+ (UIColor *)color_454545_9;

+ (UIColor *)color_F1974A;

+ (UIColor *)color_E5E5E5;

+ (UIColor *)color_CBCBCB;

+ (UIColor *)color_64482F;

+ (UIColor *)color_AE987C;

+ (UIColor *)color_644830;

+ (UIColor *)color_649FF4;

+ (UIColor *)color_FE7B45;

+ (UIColor *)color_F33C48;

+ (UIColor *)color_F8E8CA;

+ (UIColor *)color_FEFDEB;

+ (UIColor *)color_ECECEC;

+ (UIColor *)color_F2503B;

+ (UIColor *)color_75430E;

+ (UIColor *)color_6A6022;

+ (UIColor *)color_FFF8CA;

+ (UIColor *)color_FFF3EB;

+ (UIColor *)color_FF614D;

+ (UIColor *)color_FEBE96;

+ (UIColor *)color_FB6472;

+ (UIColor *)color_DEF2FF;

+ (UIColor *)color_FE5C00;

+ (UIColor *)color_FFE9CB;

+ (UIColor *)color_0054FF;

+ (UIColor *)color_FFC61C;

+ (UIColor *)color_F6F6F8;

+ (UIColor *)color_2296FF;

+ (UIColor *)color_FF5C33;

+ (UIColor *)color_0074FF;

+ (UIColor *)color_F2F5FF;

//渐变
+ (UIColor *)color_FF9B0A;
+ (UIColor *)color_FF630B;

+ (UIColor *)color_FF3A30;
+ (UIColor *)color_FE6B2E;

@end
