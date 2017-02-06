//
//  TabMainVC.h
//  AppOne
//
//  Created by lile on 15/9/14.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "OneBaseVC.h"
#import "MJRefresh.h"

@interface TabMainVC : OneBaseVC<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@end
