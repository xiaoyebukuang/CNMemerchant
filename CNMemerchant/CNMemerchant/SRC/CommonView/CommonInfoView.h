//
//  CommonInfoView.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/25.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonInfoView;

typedef NS_ENUM(NSInteger, CommonInfoType) {
    CommonInfoNetworkNone,              //请求失败
    CommonInfoHomeNoData,               //无数据
    CommonInfoHomeAllNoData,            //无数据
};

typedef void(^CommonInfoBlock)(CommonInfoView *infoView);

@interface CommonInfoView : UIView

+ (CommonInfoView *)showInfoViewSuperView:(UIView *)superView commonInfoType:(CommonInfoType)type;
+ (CommonInfoView *)showInfoViewSuperView:(UIView *)superView commonInfoType:(CommonInfoType)type commonInfoBlock:(CommonInfoBlock)commonInfoBlock;
+ (CommonInfoView *)showInfoViewSuperView:(UIView *)superView commonInfoType:(CommonInfoType)type showMes:(NSString *)showMes;
+ (CommonInfoView *)showInfoViewSuperView:(UIView *)superView commonInfoType:(CommonInfoType)type showMes:(NSString *)showMes commonInfoBlock:(CommonInfoBlock)commonInfoBlock;



+ (void)removeInfoViewFromSuperView:(UIView *)superView;


@end
