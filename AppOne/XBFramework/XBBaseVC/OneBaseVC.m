//
//  OneBaseVC.m
//  OneYuan
//
//  Created by Peter Jin (https://github.com/JxbSir) on  15/2/18.
//  Copyright (c) 2015年 PeterJin.   Email:i@jxb.name      All rights reserved.
//

#import "OneBaseVC.h"
#import "BaseNoDataView.h"
#import "BaseLoadView.h"

@interface OneBaseVC ()<UIGestureRecognizerDelegate>
{
    BaseNoDataView      *viewEmpty;
    BaseLoadView        *viewLoad;
}
@end

@implementation OneBaseVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"%@ dealloc", [self class]);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSInteger count = self.navigationController.viewControllers.count;
    self.navigationController.interactivePopGestureRecognizer.enabled = count > 1;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;//
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:22], NSFontAttributeName,nil]];

    
    viewEmpty = [[BaseNoDataView alloc] initWithFrame:self.view.bounds];
    viewLoad = [[BaseLoadView alloc] initWithFrame:self.view.bounds];
}
-(void)viewWillAppear:(BOOL)animated{
    }


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


#pragma mark - Empty
- (void)showEmpty
{
    viewEmpty.frame = self.view.bounds;
    [self.view addSubview:viewEmpty];
}

- (void)showEmpty:(CGRect)frame
{
    viewEmpty.frame = frame;
    [self.view addSubview:viewEmpty];
}

- (void)hideEmpty
{
    [viewEmpty removeFromSuperview];
}
#pragma mark - load
- (void)showLoad
{
    viewLoad.frame = self.view.bounds;
    [self.view addSubview:viewLoad];
}
- (void)hideLoad
{
    [viewLoad removeFromSuperview];
}
@end
