//
//  CourseIntroductionVC.m
//  AppOne
//
//  Created by lile on 15/10/22.
//  Copyright © 2015年 lile. All rights reserved.
//

#import "CourseIntroductionVC.h"
#import "CourseDescriptionVC.h"
#import "LoginInfoVC.h"

@interface CourseIntroductionVC ()

@end

@implementation CourseIntroductionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(mainWidth/2-50, 70, 100, 150)];
    iconImageView.image = [UIImage imageNamed:@"statistics_icon_water"];
    [self.view addSubview:iconImageView];
    
    UIButton *courseDescriptionBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2-121, 240, 242, 54)];
    [courseDescriptionBtn setBackgroundImage:[UIImage imageNamed:@"btn_ksxx"] forState:UIControlStateNormal];
    [courseDescriptionBtn addTarget:self action:@selector(startLearnBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:courseDescriptionBtn];
    
    
    UIButton *startLearnBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2-121, 330, 242, 54)];
    [startLearnBtn setBackgroundImage:[UIImage imageNamed:@"btn_kcsm"] forState:UIControlStateNormal];
    [startLearnBtn addTarget:self action:@selector(courseDescriptionBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:startLearnBtn];
    
    
    __weak typeof (self) wSelf = self;
    
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
        // [wSelf dismissViewControllerAnimated:YES completion:nil];
    }];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
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


-(void)courseDescriptionBtnAction{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    CourseDescriptionVC *vc = [[CourseDescriptionVC alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
   // UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    window.rootViewController = nav;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)startLearnBtnAction{
    NSLog(@"start");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    if(token !=nil){
        UIViewController *rootViewController = [self setRootVC];
        [window setRootViewController:rootViewController];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        LoginInfoVC *vc = [[LoginInfoVC alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
        window.rootViewController = nav;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (UITabBarController*)setRootVC
{
    LaunchViewController *homeVC =[[LaunchViewController alloc]init];
    //homeVC.hidesBottomBarWhenPushed = YES;
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UIImage *unselectedImage = [UIImage imageNamed:@"tab_home_icon"];
    UIImage *selectedImage = [UIImage imageNamed:@"tab_home_icon_s"];
    
    //unselectedImage= [unselectedImage TransformtoSize:CGSizeMake(27, 26) ];
    //selectedImage =  [selectedImage TransformtoSize:CGSizeMake(27, 26) ];
    
    homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    homeVC.tabBarItem.tag = 0;
    
    
    TabMainVC *contentsVC = [[TabMainVC alloc] init];
    UINavigationController *contentsNav = [[UINavigationController alloc] initWithRootViewController:contentsVC];
    unselectedImage = [UIImage imageNamed:@"ico_menu"];
    selectedImage = [UIImage imageNamed:@"ico_menu_s"];
    
    //unselectedImage= [unselectedImage TransformtoSize:CGSizeMake(27, 26) ];
    //selectedImage =  [selectedImage TransformtoSize:CGSizeMake(27, 26) ];
    
    contentsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"目录"
                                                          image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                  selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    contentsVC.tabBarItem.tag = 1;
    
    
    
    TabFarvoriteVC *proVC = [[TabFarvoriteVC alloc] init];
    UINavigationController *proNav = [[UINavigationController alloc] initWithRootViewController:proVC];
    unselectedImage = [UIImage imageNamed:@"ico_collection"];
    selectedImage = [UIImage imageNamed:@"ico_collection_s"];
    
    //unselectedImage= [unselectedImage TransformtoSize:CGSizeMake(27, 26) ];
    //selectedImage =  [selectedImage TransformtoSize:CGSizeMake(27, 26) ];
    
    proNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"收藏"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    proNav.tabBarItem.tag = 2;
    
    TabPersonInfoVC * newVc = [[TabPersonInfoVC alloc] init];
    UINavigationController * newNav = [[UINavigationController alloc] initWithRootViewController:newVc];
    unselectedImage = [UIImage imageNamed:@"ico_me"];
    selectedImage = [UIImage imageNamed:@"ico_me_s"];
    //unselectedImage= [unselectedImage TransformtoSize:CGSizeMake(27, 26) ];
    //selectedImage =  [selectedImage TransformtoSize:CGSizeMake(27, 26) ];
    
    newNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心"
                                                      image:[unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                              selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    newNav.tabBarItem.tag = 3;
    
    
    
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    tabBarController.viewControllers = @[homeNav,contentsNav,proNav,newNav];
    
    //  tabBarController.delegate = self;
    
    
    // customise TabBar UI Effect
    [UITabBar appearance].tintColor = BG_COLOR;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:TABBAR_TEXT_NOR_COLOR} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVBAR_COLOR} forState:UIControlStateSelected];
    
    // customise NavigationBar UI Effect
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithRenderColor:NAVBAR_COLOR renderSize:CGSizeMake(10., 10.)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    UITabBar *tabBar = tabBarController.tabBar;
    tabBar.backgroundColor = BG_COLOR;
    
    return tabBarController;
}

@end
