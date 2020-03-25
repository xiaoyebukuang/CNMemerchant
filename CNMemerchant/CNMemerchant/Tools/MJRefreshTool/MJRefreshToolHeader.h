//
//  MJRefreshToolHeader.h
//  cwz51
//
//  Created by 陈晓 on 2018/10/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface MJRefreshToolHeader : MJRefreshHeader

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;

@end
