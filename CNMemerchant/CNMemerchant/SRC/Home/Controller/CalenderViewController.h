//
//  CalenderViewController.h
//  cwz51
//
//  Created by 陈晓 on 2019/6/5.
//  Copyright © 2019年 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CalenderViewControllerDelegate <NSObject>

- (void)didSelectDateStrWithDateStr:(NSString *)dateStr;

@end

@interface CalenderViewController : BaseMultiViewController

@property (nonatomic, weak)id<CalenderViewControllerDelegate>delegate;

@property (nonatomic, copy) NSString *startDateStr;

@property (nonatomic, copy) NSString *endDateStr;

@property (nonatomic, copy) NSString *selectDateStr;

@end

NS_ASSUME_NONNULL_END
