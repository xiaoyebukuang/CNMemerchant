//
//  BaseTableViewCell.m
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/2.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor color_FFFFFF];
        [self setupUI];
    }
    return self;
}
/** 子类实现 */
- (void)setupUI {
    
}
@end
