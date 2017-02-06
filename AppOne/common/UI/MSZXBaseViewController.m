//
//  MSZXBaseViewController.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-2.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXBaseViewController.h"

@interface MSZXBaseViewController ()

- (void)setDefaultLayout;

@end

@implementation MSZXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDefaultLayout];
    self.view.backgroundColor = VIEWCONTROLLERBACKGROUNDCOLOR;
    
    if (!self.isNavbarHidden)
    {
        [self initNavBarView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)contentViewFrame
{
    CGFloat gapY;
    if (self.isNavbarHidden)
    {
        gapY = 0;
    }
    else
    {
        gapY = self.navBarView.frame.size.height;
    }
    
    CGRect tmpFrame = CGRectMake(0,
                                 gapY,
                                 ScreenWidth,
                                 ScreenHeight - self.navBarView.frame.size.height);
    
    return tmpFrame;
}

#pragma mark - private method
- (void)initNavBarView
{
    MSZXNavBarView *tmpNavBarView = [[MSZXNavBarView alloc] initWithFrame:NAV_BAR_FRAME];
    self.navBarView = tmpNavBarView;
    
    [self.view addSubview:self.navBarView];
}

- (void)setDefaultLayout
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    if (IOS6_OR_EARLIER)
    {
        self.view.frame = CGRectMake(0, 0,
                                     self.view.bounds.size.width,
                                     self.view.bounds.size.height);
    }
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (IOS7_OR_LATER)
    {
        return UIStatusBarStyleLightContent;
    }
    else
    {
        return UIStatusBarStyleBlackOpaque;
    }
}

#pragma mark - viewController rotate method
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Navigation Item
- (MSZXBarButtonItem *)backButtonItem
{
    return [[MSZXBarButtonItem alloc] initBackWithTarget:self action:@selector(doNavigationBack)];
}

- (void)doNavigationBack
{
    if(self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
