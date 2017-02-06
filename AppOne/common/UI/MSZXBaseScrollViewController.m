//
//  MSZXBaseScrollViewController.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-20.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXBaseScrollViewController.h"

@interface MSZXBaseScrollViewController ()

@end

@implementation MSZXBaseScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *tmpMainView = [[UIScrollView alloc] initWithFrame:[self contentViewFrame]];
    tmpMainView.backgroundColor = self.view.backgroundColor;
    tmpMainView.alwaysBounceVertical = YES;
    self.mainView = tmpMainView;
    [self.view addSubview:self.mainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
