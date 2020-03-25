//
//  MJRefreshToolHeader.m
//  cwz51
//
//  Created by 陈晓 on 2018/10/19.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "MJRefreshToolHeader.h"

@interface MJRefreshToolHeader()

@property (nonatomic, strong) UIImageView *gifView;
/** 所有状态对应的动画图片 */
@property (nonatomic, strong) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (nonatomic, strong) NSMutableDictionary *stateDurations;

@end
@implementation MJRefreshToolHeader

#pragma mark - 懒加载
- (UIImageView *)gifView {
    if (!_gifView) {
        _gifView = [[UIImageView alloc] init];
    }
    return _gifView;
}
- (NSMutableDictionary *)stateImages {
    if (!_stateImages) {
        _stateImages = [NSMutableDictionary dictionary];
    }
    return _stateImages;
}
- (NSMutableDictionary *)stateDurations {
    if (!_stateDurations) {
        _stateDurations = [NSMutableDictionary dictionary];
    }
    return _stateDurations;
}
#pragma mark - 公共方法
/** 状态改变 */
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        NSArray *images = self.stateImages[@(state)];
        if (images.count == 0) return;
        [self.gifView stopAnimating];
        if (images.count == 1) { // 单张图片
            self.gifView.image = [images lastObject];
        } else { // 多张图片
            self.gifView.animationImages = images;
            self.gifView.animationDuration = [self.stateDurations[@(state)] doubleValue];
            [self.gifView startAnimating];
        }
    }
}
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state {
    if (images == nil) return;
    self.stateImages[@(state)] = images;
    self.stateDurations[@(state)] = @(duration);
}
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state {
    [self setImages:images duration:images.count * 0.1 forState:state];
}
#pragma mark - 实现父类的方法
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    NSArray *images = self.stateImages[@(MJRefreshStateIdle)];
    if (self.state != MJRefreshStateIdle || images.count == 0) return;
    // 停止动画
    [self.gifView stopAnimating];
    // 设置当前需要显示的图片
    NSUInteger index =  images.count * pullingPercent;
    if (index >= images.count) index = images.count - 1;
    self.gifView.image = images[index];
}
- (void)placeSubviews {
    [super placeSubviews];
    [self addSubview:self.gifView];
    self.mj_h = WIDTH_ADAPTER(90) - self.ignoredScrollViewContentInsetTop;
    self.gifView.frame = self.bounds;
    self.gifView.mj_h = WIDTH_ADAPTER(90);
}
@end
