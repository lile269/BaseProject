//
//  CourseDescriptionVC.m
//  AppOne
//
//  Created by lile on 15/10/22.
//  Copyright © 2015年 lile. All rights reserved.
//

#import "CourseDescriptionVC.h"
#import "LoginInfoVC.h"

@interface CourseDescriptionVC ()

@end

@implementation CourseDescriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"课程说明";
    [self.tabBarController.tabBar setHidden:NO];

   // NSDictionary *commonQuestionHead =[[Commondata sharedInstance]commonQuestionHead];
    
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 300, 10)];
    
    label1.text = @"《商务英语听说》配套练习";
    label1.font = [UIFont boldSystemFontOfSize:19];
    
    [self.view  addSubview:label1];
    
    
    // content = [content stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    NSString * descripttion = @"    本APP是为教育部“中等职业教育改革创新示范教材” 《商务英语听说》开发的配套训练教材。内容分为两个部分，1-12课为一般性话题，13-24课为商务话题。包含教材中1-24课中“listening Activities”部分全部内容，提供键盘输入和语音录存方式提交答案，并提供与正确答案的对比。具有实用性和便捷性。";
    UILabel *contentLabel  = [[UILabel alloc] init];
    contentLabel.text          = descripttion;
    contentLabel.numberOfLines = 0;// 需要把显示行数设置成无限制
    contentLabel.font          = [UIFont fontWithName:@"Arial" size:15];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    CGSize size                = [self sizeWithString:contentLabel.text font:contentLabel.font cotentType:@"01"];
    contentLabel.frame         = CGRectMake(13, 50, size.width, size.height);
    
    [self.view addSubview:contentLabel];
    
//    UIButton *startQuestionBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2-121, size.height+130, 242, 54)];
//    [startQuestionBtn setBackgroundImage:[UIImage imageNamed: @"btn_ksxx"] forState:UIControlStateNormal];
//    //[startQuestionBtn setTitle:@"     开始答题" forState:UIControlStateNormal];
//    [startQuestionBtn setTintColor:[UIColor whiteColor]];
//    [startQuestionBtn addTarget:self action:@selector(startLearnAction) forControlEvents:UIControlEventTouchDown];
//    [self.view  addSubview:startQuestionBtn];
    
    NSString * descripttion2 = @" 出版：北京财经电子音像出版社\nISBN：978-7-5095-4973-5\n2015年11月第1版";
    UILabel *contentLabel2  = [[UILabel alloc] init];
   // contentLabel2.text          = descripttion2;
    contentLabel2.numberOfLines = 0;// 需要把显示行数设置成无限制
    contentLabel2.font          = [UIFont boldSystemFontOfSize:14];
    contentLabel2.textAlignment = NSTextAlignmentLeft;
    CGSize size2                = [self sizeWithString:contentLabel2.text font:contentLabel2.font cotentType:@"01"];
    contentLabel2.frame         = CGRectMake(13, 50+size.height+20, size2.width, size2.height);
    
    
    
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:descripttion2];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [descripttion2 length])];
    [contentLabel2 setAttributedText:attributedString1];
    [contentLabel2 sizeToFit];
    [self.view addSubview:contentLabel2];
    
    
    
    NSString * descripttion3 = @" 纸质教材：《商务英语听说》\n 主编：车丽娟\nISBN：978-7-5095-4973-5\n 出版：中国财经经济出版社\n2015年  月第  版    定价：  元";
    UILabel *contentLabel3  = [[UILabel alloc] init];
    // contentLabel2.text          = descripttion2;
    contentLabel3.numberOfLines = 0;// 需要把显示行数设置成无限制
    contentLabel3.font          = [UIFont boldSystemFontOfSize:14];
    contentLabel3.textAlignment = NSTextAlignmentLeft;
    CGSize size3                = [self sizeWithString:contentLabel3.text font:contentLabel3.font cotentType:@"01"];
    contentLabel3.frame         = CGRectMake(13, 155+size.height+size2.height, size3.width, size3.height);
    
    
    
    
    NSMutableAttributedString * attributedString2 = [[NSMutableAttributedString alloc] initWithString:descripttion3];
    NSMutableParagraphStyle * paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:8];
    [attributedString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [descripttion3 length])];
    [contentLabel3 setAttributedText:attributedString2];
    [contentLabel3 sizeToFit];
    [self.view addSubview:contentLabel3];

    
    
    
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



-(void)startLearnAction{
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

#pragma mark - Navigation

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font cotentType:(NSString *)cotentType
{
    //题干
    if([cotentType isEqualToString:@"01"]){
        CGRect rect = [string boundingRectWithSize:CGSizeMake(mainWidth-15, 400)//限制最大的宽度和高度
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                        attributes:@{NSFontAttributeName: font}//传人的字体字典
                                           context:nil];
        
        return rect.size;}
    else{//问题选项
        CGRect rect = [string boundingRectWithSize:CGSizeMake(mainWidth-40, 400)//限制最大的宽度和高度
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                        attributes:@{NSFontAttributeName: font}//传人的字体字典
                                           context:nil];
        return rect.size;
    }
}



@end
