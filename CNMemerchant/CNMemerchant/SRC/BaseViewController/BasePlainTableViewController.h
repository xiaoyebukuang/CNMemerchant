//
//  BasePlainTableViewController.h
//  CNMemerchant
//
//  Created by 陈晓 on 2020/3/3.
//  Copyright © 2020 XYBK. All rights reserved.
//

#import "BaseMultiViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BasePlainTableViewController : BaseMultiViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
