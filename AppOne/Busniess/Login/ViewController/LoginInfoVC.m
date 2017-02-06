//
//  LoginInfoVC.m
//  AppOne
//
//  Created by lile on 15/8/12.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "LoginInfoVC.h"
#import "LoginModel.h"
#import "GetUserInfo.h"
#import "CourseListModel.h"
#import "RegUserVC.h"
#import "SetDevieceUUID.h"
#import "BELoginModel.h"
#import "TabMainVC.h"
#import "TabPersonInfoVC.h"
#import "Mobclick.h"


@interface LoginInfoVC (){
    UITextField     *txtUser;
    UITextField     *txtPwd;
}

@end

@implementation LoginInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.title = @"登录";
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];

    [self initLoginView];
    NSLog(@"%@",[SetDevieceUUID getDeviceUUID]);
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
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

-(void) initLoginView{
    self.view.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
    //  __weak typeof (self) wSelf = self;
    // [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
    //   [wSelf btnBackAction];
    //}];

    UIImageView* header = [[UIImageView alloc] initWithFrame:CGRectMake(mainWidth/2-56, 64*heightRation, 113, 39)];
    NSLog(@"%f---%f",mainWidth,mainHeight);
    
    header.image = [UIImage imageNamed:@"login_pic_logo.png"];
    [self.view addSubview:header];
    
    CGFloat currentY = 64*heightRation+39;
  
    
    
    UIView* vUser = [[UIView alloc] initWithFrame:CGRectMake(0, currentY+27, mainWidth, 100)];
    vUser.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vUser];
    
    
    UIImageView* line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, mainWidth, 0.5)];
    line.backgroundColor = [UIColor hexFloatColor:@"dedede"];
    [vUser addSubview:line];
    
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(mainWidth/2-50, 13, 20, 24)];
    imgUser.image = [UIImage imageNamed:@"login_ico_account"];
    [vUser addSubview:imgUser];
    
    txtUser = [[UITextField alloc] initWithFrame:CGRectMake(mainWidth/2-25, 0, mainWidth/2+10, 50)];
    txtUser.placeholder = @"请输入账号";
    txtUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtUser.font = [UIFont systemFontOfSize:14];
    txtUser.text = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    txtUser.delegate = self;
    [vUser addSubview:txtUser];
    
    
    UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(mainWidth/2-50, 63, 20, 24)];
    imgPwd.image = [UIImage imageNamed:@"login_ico_password"];
    [vUser addSubview:imgPwd];
    
    txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(mainWidth/2-25, 50, mainWidth/2+10, 50)];
    txtPwd.placeholder = @"请输入密码";
    txtPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtPwd.font = [UIFont systemFontOfSize:14];
    txtPwd.secureTextEntry = YES;
    txtPwd.delegate = self;
    [vUser addSubview:txtPwd];

    currentY = currentY +27+120;
    
    UIButton* btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(40*widthRation, currentY, mainWidth - 80*widthRation, 51)];
    btnLogin.layer.cornerRadius = 5;
    btnLogin.backgroundColor = NAVBAR_COLOR;
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:20];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];

    
    currentY = currentY + 51 + 32;
    
    UIButton* btnReg = [[UIButton alloc] initWithFrame:CGRectMake(40*widthRation, currentY, mainWidth - 80*widthRation, 51)];
    [btnReg setTitle:@"注册" forState:UIControlStateNormal];
    btnReg.titleLabel.font = [UIFont systemFontOfSize:20];
    UIImage * regImg = [UIImage imageNamed:@"login_btn_registered"];
    [btnReg setBackgroundImage:regImg forState:UIControlStateNormal];
    [btnReg setTitleColor:[UIColor hexFloatColor:@"00aeef"] forState:UIControlStateNormal];
    [btnReg addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReg];
    
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}



-(void)loginAction{
    [txtPwd resignFirstResponder];
    [txtUser resignFirstResponder];
    if(txtUser.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入账号"];
        return;
    }
    if(txtPwd.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入密码"];
        return;
    }
    [[XBToastManager ShardInstance] showprogress];
    
    BELoginModel *api = [[BELoginModel alloc] initWithUsername:txtUser.text password:txtPwd.text deviceId:[SetDevieceUUID getDeviceUUID]];

    //LoginMode *api = [[LoginMode alloc] initWithUsername:txtUser.text password:txtPwd.text];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"succeed");
        [[XBToastManager ShardInstance] hideprogress];
        NSDictionary *root =nil;
        if([api isDataFromCache])
        {
            root = [api cacheJson];
        }
        else
        {
            NSLog(@"api%@",api.responseString);
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        
        NSLog(@"收获的数据:%@",root);
        
        NSString *state = [root objectForKey:@"state"];
        NSString *info = [root objectForKey:@"info"];
        
        if([state intValue]==1||[state intValue]==2)
        {
           // NSDictionary *result = [root objectForKey:@"result"];
            //NSString *token =[result objectForKey:@"token"];
            NSString *token =[root objectForKey:@"result"];
            NSLog(@"token:%@",token);
            
            [[Commondata sharedInstance] setLoginState:@"true"];
            [[NSUserDefaults standardUserDefaults] setObject:txtUser.text forKey:kLoginUsername];
            [[NSUserDefaults standardUserDefaults] setObject:txtPwd.text forKey:kLoginUserpwd];
            [MobClick profileSignInWithPUID:txtUser.text];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:kToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
           // [self getUserinfo]
          /*
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            FirstPageVC *vc = [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
            */
            
            //[vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [self setRootVC];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
            //[self presentViewController:vc animated:YES completion:nil];
            
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                            message: nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"连接失败失败"];
        
    }];
    
}

-(void)registAction{
   
    RegUserVC* vc  = [[RegUserVC alloc]init];
   // UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    //self.navigationController.navigationBarHidden = NO;
    //[self presentViewController:nav animated:YES completion:nil];
    //[vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self.navigationController pushViewController:vc animated:YES];

}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
}

#pragma mark 触摸背景来关闭虚拟键盘
-(void)backgroundTap
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0.0f, 64.0f, self.view.frame.size.width, self.view.frame.size.height);
//    self.view.frame = rect;
//    [UIView commitAnimations];
    
    [txtUser resignFirstResponder];
    [txtPwd resignFirstResponder];

    // [textField2 resignFirstResponder];
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
    
    tabBarController.selectedIndex = [[Commondata sharedInstance]selectedIndex];
    
    return tabBarController;
}


@end
