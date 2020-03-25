//
//  CalenderViewController.m
//  cwz51
//
//  Created by 陈晓 on 2019/6/5.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import "CalenderViewController.h"
#import "CalenderView.h"
@interface CalenderViewController ()<CalenderViewDelegate>

@property (nonatomic, strong) CalenderView *calenderView;

@end

@implementation CalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择日期";
    [self setupUI];
}
- (void)setupUI {
    [self.view addSubview:self.calenderView];
}
#pragma mark -- CalenderViewDelegate
- (void)selectDateWithDateStr:(NSString *)selectDateStr {
    self.selectDateStr = selectDateStr;
    if ([self.delegate respondsToSelector:@selector(didSelectDateStrWithDateStr:)]) {
        [self.delegate didSelectDateStrWithDateStr:selectDateStr];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- setup
- (CalenderView *)calenderView {
    if (!_calenderView) {
        _calenderView = [[CalenderView alloc]initWithFrame:self.view.bounds startDay:self.startDateStr endDay:self.endDateStr];
        _calenderView.selectedDateStr = self.selectDateStr;
        _calenderView.delegate = self;
    }
    return _calenderView;
}



@end
