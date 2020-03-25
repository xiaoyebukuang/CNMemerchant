//
//  UIScrollView+Helper.m
//  cwz51
//
//  Created by 陈晓 on 2018/11/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIScrollView+Helper.h"
#import "MJRefreshToolHeader.h"
@implementation UIScrollView (Helper)
#pragma mark -- 添加刷新控件
/** 添加上拉刷新 */
- (void)addRefreshHeaderBlock:(void (^)(void))headerBlock {
    [self addRefreshHeaderBlock:headerBlock footerBlock:nil];
}
/** 添加上拉刷新 */
- (void)addRefreshHiddenStateBar:(BOOL)hiddenStateBar headerBlock:(void (^)(void))headerBlock {
    [self addRefreshHiddenStateBar:hiddenStateBar insetTop:0 headerBlock:headerBlock footerBlock:nil];
}
/** 添加下拉加载 */
- (void)addRefreshFooterBlock:(void (^)(void))footerBlock {
    [self addRefreshHeaderBlock:nil footerBlock:footerBlock];
}
/** 添加上拉刷新，下拉加载 */
- (void)addRefreshHeaderBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock {
    [self addRefreshHiddenStateBar:YES headerBlock:headerBlock footerBlock:footerBlock];
}
/** 添加上拉刷新，下拉加载 */
- (void)addRefreshHiddenStateBar:(BOOL)hiddenStateBar headerBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock {
    [self addRefreshHiddenStateBar:hiddenStateBar insetTop:0 headerBlock:headerBlock footerBlock:footerBlock];
}
/** 添加上拉刷新，下拉加载 */
- (void)addRefreshHiddenStateBar:(BOOL) hiddenStateBar insetTop:(CGFloat)insetTop headerBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock {
    
    if (headerBlock) {
        //头视图
        WeakSelf;
        MJRefreshToolHeader *mj_header = [MJRefreshToolHeader headerWithRefreshingBlock:^{
            if (!weakSelf.footerIsRefreshing) {
                headerBlock();
            } else {
                [weakSelf endHeaderRefresh];
            }
        }];
        mj_header.ignoredScrollViewContentInsetTop = insetTop;
        self.mj_header = mj_header;
        // 刷新动画
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"car" withExtension:@"gif"];//加载GIF图片
        CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);//将GIF图片转换成对应的图片源
        size_t frameCout=CGImageSourceGetCount(gifSource);//获取其中图片源个数，即由多少帧图片组成
        NSMutableArray* frames = [[NSMutableArray alloc] init];//定义数组存储拆分出来的图片
        for (size_t i=0; i < frameCout; i++) {
            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);//从GIF图片中取出源图片
            UIImage* imageName = [UIImage imageWithCGImage:imageRef];//将图片源转换成UIimageView能使用的图片源
            [frames addObject:imageName];//将图片加入数组中
            CGImageRelease(imageRef);
        }
        [mj_header setImages:frames forState:MJRefreshStateIdle];
        [mj_header setImages:frames forState:MJRefreshStatePulling];
        [mj_header setImages:frames forState:MJRefreshStateWillRefresh];
        // 设置正在刷新状态的动画图片
        [mj_header setImages:frames forState:MJRefreshStateRefreshing];
    }
    if (footerBlock) {
        //尾视图
        WeakSelf;
        MJRefreshBackStateFooter *mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            if (!weakSelf.headerIsRefreshing) {
                footerBlock();
            } else {
                [weakSelf endFooterRefresh];
            }
        }];
        [mj_footer setTitle:@"已经到底了" forState:MJRefreshStateNoMoreData];
        self.mj_footer = mj_footer;
    }
}
#pragma mark -- 状态
/** 开始刷新 */
- (void)beginRefresh {
    [self.mj_header beginRefreshing];
}

/** 结束刷新和加载 */
- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

/** 结束加载 */
- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}
- (void)endFooterRefreshCompletionBlock:(void (^)(void))completionBlock {
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshingWithCompletionBlock:completionBlock];
    } else {
        completionBlock();
    }
}

/** 结束刷新 */
- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
}
- (void)endHeaderRefreshCompletionBlock:(void (^)(void))completionBlock {
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshingWithCompletionBlock:completionBlock];
    } else {
        completionBlock();
    }
}
/** 已无数据可加载 */
- (void)endRefreshNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}
/** 是否在刷新 */
- (BOOL)footerIsRefreshing {
    return [self.mj_footer isRefreshing];
}
- (BOOL)headerIsRefreshing {
    return [self.mj_header isRefreshing];
}
- (BOOL)isRefreshing {
    BOOL isRe = [self.mj_header isRefreshing] || [self.mj_footer isRefreshing];
    return isRe;
}
/** 隐藏显示刷新 */
- (void)setHeaderRefreshHidden:(BOOL)hidden {
    self.mj_header.hidden = hidden;
}
- (void)setFooterRefreshHidden:(BOOL)hidden {
    self.mj_footer.hidden = hidden;
}
@end
