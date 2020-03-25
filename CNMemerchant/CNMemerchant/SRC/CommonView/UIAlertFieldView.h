//
//  UIAlertFieldView.h
//  cwz51
//
//  Created by 陈晓 on 2019/1/18.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UIAlertFieldType) {
    UIAlertFieldTypeSure,        //选择框
};
@interface UIAlertFieldView : UIView

- (instancetype)initWithAlertFieldType:(UIAlertFieldType)alertFieldType;
- (instancetype)initWithAlertFieldType:(UIAlertFieldType)alertFieldType leftStr:(NSString *)leftStr rightStr:(NSString *)rightStr;

/** 展示 */
- (void)showAlertSureWithTitle:(NSString *)title callBack:(void(^)(NSInteger index))alertCallBlock;
/** 消失 */
- (void)dismiss;

@end
