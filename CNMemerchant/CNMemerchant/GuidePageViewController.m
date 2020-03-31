//
//  GuidePageViewController.m
//  cwz51
//
//  Created by 陈晓 on 2018/11/22.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "GuidePageViewController.h"
#import "AppDelegate.h"
@interface GuidePageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *expeBtn;

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor color_FFFFFF];
    [self setupView];
    [self setData];
}
- (void)setupView {
    self.scrollView.backgroundColor = [UIColor color_FFFFFF];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).mas_offset(- IPHONEX_BOTTOW_HEIGHT - 84);
        make.height.mas_equalTo(30);
    }];
}
- (void)setData {
    NSInteger number = 1;
    UIView *subView = [[UIView alloc]init];
    subView.backgroundColor = [UIColor color_F2F5FF];
    [self.scrollView addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView);
        make.width.mas_equalTo(MAIN_SCREEN_WIDTH);
        make.height.mas_equalTo(MAIN_SCREEN_HEIGHT);
    }];
    
    NSString *imageStr = @"guide_page";
    CGFloat btn_width = 165;
    CGFloat btn_height = 44;
    UIFont *btn_font = SYSTEM_FONT_B_18;
    CGFloat btn_top_offset = 0;
    if (IPHONEX_MORE) {
        imageStr = @"guide_page_x";
        btn_top_offset = 15;
    }
    UIImage *image = [UIImage imageNamed:imageStr];
    UIImageView *imageView01 = [[UIImageView alloc]initWithImage:image];
    [subView addSubview:imageView01];
    [imageView01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(subView);
        make.height.mas_equalTo(image.size.height*MAIN_SCREEN_WIDTH/image.size.width);
    }];
    self.expeBtn.layer.cornerRadius = btn_height/2;
    self.expeBtn.titleLabel.font = btn_font;
    [subView addSubview:self.expeBtn];
    [self.expeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView01);
        make.top.equalTo(imageView01.mas_bottom).mas_offset(btn_top_offset);
        make.width.mas_equalTo(btn_width);
        make.height.mas_equalTo(btn_height);
    }];
    self.scrollView.contentSize = CGSizeMake(MAIN_SCREEN_WIDTH * number, MAIN_SCREEN_HEIGHT);
    self.pageControl.numberOfPages = number;
    self.pageControl.hidden = (number == 1);
}
- (void)expeBtnEvent:(UIButton *)btn {
    NSString *currentVersion = [UIDevice getAppVersion];
    [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:USERDEFAULTS_APP_VERSION];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [kApplicationDelegate setRootViewControoler];
}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = currentPage;
}
#pragma mark -- setup
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = YES;
    }
    return _scrollView;
}
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor color_808080];
        _pageControl.pageIndicatorTintColor = [UIColor color_E2E2E2];
    }
    return _pageControl;
}
- (UIButton *)expeBtn {
    if (!_expeBtn) {
        _expeBtn = [UIButton buttonWithTitle:@"立即体验" titleColor:[UIColor color_FFFFFF] font:SYSTEM_FONT_B_26];
        _expeBtn.backgroundColor = [UIColor color_0074FF];
        _expeBtn.layer.masksToBounds = YES;
        [_expeBtn addTarget:self action:@selector(expeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expeBtn;
}
@end
