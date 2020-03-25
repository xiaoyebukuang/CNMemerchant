//
//  UILabel+Helper.m
//  XYBKDemo
//
//  Created by 陈晓 on 2018/10/4.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)

- (instancetype)initWithTextColor:(UIColor *)textColor font:(UIFont *)font lineSpacing:(NSInteger)lineSpacing {
    self = [super init];
    if (self) {
        self.textColor = textColor;
        self.font = font;
        [self setValue:@(lineSpacing) forKey:@"lineSpacing"];
    }
    return self;
}
- (instancetype)initWithTextColor:(UIColor *)textColor font:(UIFont *)font {
    self = [super init];
    if (self) {
        self.textColor = textColor;
        self.font = font;
    }
    return self;
}
- (instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {
    self = [super init];
    if (self) {
        self.text = text;
        self.textColor = textColor;
        self.font = font;
    }
    return self;
}
- (instancetype)initWithTextColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font {
    self = [super init];
    if (self) {
        self.textColor = textColor;
        self.font = font;
        self.textAlignment = textAlignment;
    }
    return self;
}
- (instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font {
    self = [super init];
    if (self) {
        self.text = text;
        self.textColor = textColor;
        self.textAlignment = textAlignment;
        self.font = font;
    }
    return self;
}
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment
                        font:(UIFont *)font
                 lineSpacing:(CGFloat)lineSpacing {
    self = [super init];
    if (self) {
        self.textColor = textColor;
        self.textAlignment = textAlignment;
        self.font = font;
        [self reloadTitleWithTitle:text lineSpacing:lineSpacing textAlignment:textAlignment];
    }
    return self;
}
- (void)reloadTitleWithTitle:(NSString *)title lineSpacing:(CGFloat)lineSpacing textAlignment:(NSTextAlignment)textAlignment {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.alignment = textAlignment;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
- (void)reloadTitleWithTitle:(NSString *)title lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpacing;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:title attributes:attributes];
}


//TODO:业务需要
/** 边框label */
- (instancetype)initDiscountLabel {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor color_FFFFFF];
        self.textColor = [UIColor color_FF7E3F];
        self.textAlignment = NSTextAlignmentCenter;
        self.font = SYSTEM_FONT_10;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2;
        self.layer.borderColor = [UIColor color_FF7E3F_5].CGColor;
        self.layer.borderWidth = 0.5;
    }
    return self;
}
- (CGFloat)getDiscountLabelWidthWithText:(NSString *)text {
    self.text = text;
    CGFloat btn_width = [text getStrWidthWithFont:SYSTEM_FONT_10] + 2;
    return btn_width;
}

@end
