//
//  RegUserVC.m
//  AppOne
//
//  Created by lile on 15/8/12.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "RegUserVC.h"
#import "RegisterModel.h"
#import "SetDevieceUUID.h"
#import "BERegisterModel.h"
#import "TabMainVC.h"

@interface RegUserVC (){
    UITextField *txtPhone;
    UITextField *txtUser;
    UITextField *txtPwd;
    UITextField *txtConfirmPwd;
    UITextField *txtEmail;
    UITextField *txtRegCode;
    UITextField *txtRegPassword;
    //int offset;
}

@end

@implementation RegUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
    self.title = @"注册";
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self initRegUserView];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;

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

-(void)initRegUserView{
    UIView* vvv = [[UIView alloc] initWithFrame:CGRectMake(16, 20, mainWidth - 32, 44)];
    vvv.backgroundColor = [UIColor whiteColor];
    vvv.layer.borderColor = [UIColor hexFloatColor:@"dedede"].CGColor;
    vvv.layer.borderWidth = 0.5;
    vvv.layer.cornerRadius = 3;
    [self.view addSubview:vvv];
    
    UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    img.image = [UIImage imageNamed:@"login_ico_account"];
    [vvv addSubview:img];
    
    txtUser = [[UITextField alloc] initWithFrame:CGRectMake(45, 5, mainWidth - 80, 34)];
    txtUser.backgroundColor = [UIColor whiteColor];
    
    txtUser.placeholder = @"账号";
    txtUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtUser.font = [UIFont systemFontOfSize:15];
   
    txtUser.keyboardType = UIKeyboardTypeAlphabet;
    txtUser.delegate = self;
    [vvv addSubview:txtUser];
    [txtUser becomeFirstResponder];
    
    UIView* vvv2 = [[UIView alloc] initWithFrame:CGRectMake(16, 64, mainWidth - 32, 44)];
    vvv2.backgroundColor = [UIColor whiteColor];
    vvv2.layer.borderColor = [UIColor hexFloatColor:@"dedede"].CGColor;
    vvv2.layer.borderWidth = 0.5;
    vvv2.layer.cornerRadius = 3;
    [self.view addSubview:vvv2];
    
    UIImageView* img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    img1.image = [UIImage imageNamed:@"login_ico_mail"];
    [vvv2 addSubview:img1];
    
    txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(45, 5, mainWidth - 80, 34)];
    txtEmail.backgroundColor = [UIColor whiteColor];
    txtEmail.font = [UIFont systemFontOfSize:15];
    txtEmail.placeholder = @"邮箱";
    txtEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtEmail.keyboardType = UIKeyboardTypeAlphabet;
    txtEmail.delegate = self;
    [vvv2 addSubview:txtEmail];
   // [txtEmail becomeFirstResponder];
    
    
    UIView* vvv3 = [[UIView alloc] initWithFrame:CGRectMake(16, 108, mainWidth - 32, 44)];
    vvv3.backgroundColor = [UIColor whiteColor];
    vvv3.layer.borderColor = [UIColor hexFloatColor:@"dedede"].CGColor;
    vvv3.layer.borderWidth = 0.5;
    vvv3.layer.cornerRadius = 3;
    [self.view addSubview:vvv3];
    
    UIImageView* img2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    img2.image = [UIImage imageNamed:@"login_ico_password"];
    [vvv3 addSubview:img2];
    
    txtPwd = [[UITextField alloc] initWithFrame:CGRectMake(45, 5, mainWidth - 80, 34)];
    txtPwd.backgroundColor = [UIColor whiteColor];
    txtPwd.font = [UIFont systemFontOfSize:15];
    txtPwd.placeholder = @"密码";
    txtPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtPwd.keyboardType = UIKeyboardTypeAlphabet;
    //txtPhone.keyboardType = UIKeyboardTypeNumberPad;
     txtPwd.secureTextEntry = YES;
    txtPwd.delegate = self;
    [vvv3 addSubview:txtPwd];
    //[txtPwd becomeFirstResponder];
    //152
    UIView* vvv4 = [[UIView alloc] initWithFrame:CGRectMake(16, 152, mainWidth - 32, 44)];
    vvv4.backgroundColor = [UIColor whiteColor];
    vvv4.layer.borderColor = [UIColor hexFloatColor:@"dedede"].CGColor;
    vvv4.layer.borderWidth = 0.5;
    vvv4.layer.cornerRadius = 3;
    [self.view addSubview:vvv4];
    
    UIImageView* img3 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    img3.image = [UIImage imageNamed:@"login_ico_password"];
    [vvv4 addSubview:img3];
    
    txtConfirmPwd = [[UITextField alloc] initWithFrame:CGRectMake(45, 5, mainWidth - 80, 34)];
    txtConfirmPwd.backgroundColor = [UIColor whiteColor];
    txtConfirmPwd.font = [UIFont systemFontOfSize:15];
    txtConfirmPwd.placeholder = @"确认密码";
    txtConfirmPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtConfirmPwd.secureTextEntry = YES;
    //txtPhone.keyboardType = UIKeyboardTypeNumberPad;
    txtConfirmPwd.delegate = self;
    [vvv4 addSubview:txtConfirmPwd];
   // [txtConfirmPwd becomeFirstResponder];
    
    
    
    
    //txtUser.returnKeyType = UIReturnKeyNext;
    //txtEmail.returnKeyType = UIReturnKeyNext;
    //txtPwd.returnKeyType = UIReturnKeyNext;
    //txtUser.returnKeyType = UIReturnKeyNext;
    
    txtConfirmPwd.returnKeyType = UIReturnKeyDefault;
    
    
    
    UIView* vvv5 = [[UIView alloc] initWithFrame:CGRectMake(16, 206, mainWidth - 32, 44)];
    vvv5.backgroundColor = [UIColor whiteColor];
    vvv5.layer.borderColor = [UIColor hexFloatColor:@"dedede"].CGColor;
    vvv5.layer.borderWidth = 0.5;
    vvv5.layer.cornerRadius = 3;
    [self.view addSubview:vvv5];
    
    UIImageView* img4 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    img4.image = [UIImage imageNamed:@"login_ico_code"];
    [vvv5 addSubview:img4];
    
    txtRegCode = [[UITextField alloc] initWithFrame:CGRectMake(45, 5, mainWidth - 80, 34)];
    txtRegCode.backgroundColor = [UIColor whiteColor];
    txtRegCode.font = [UIFont systemFontOfSize:15];
    txtRegCode.placeholder = @"注册码";
    txtRegCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtRegCode.keyboardType = UIKeyboardTypeAlphabet;
    //txtPhone.keyboardType = UIKeyboardTypeNumberPad;
     txtRegCode.returnKeyType = UIReturnKeyDefault;
    txtRegCode.delegate = self;
    [vvv5 addSubview:txtRegCode];

    
    UIView* vvv6 = [[UIView alloc] initWithFrame:CGRectMake(16, 250, mainWidth - 32, 44)];
    vvv6.backgroundColor = [UIColor whiteColor];
    vvv6.layer.borderColor = [UIColor hexFloatColor:@"dedede"].CGColor;
    vvv6.layer.borderWidth = 0.5;
    vvv6.layer.cornerRadius = 3;
    [self.view addSubview:vvv6];
    
    UIImageView* img5 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    img5.image = [UIImage imageNamed:@"login_ico_codepassword"];
    [vvv6 addSubview:img5];
    
    txtRegPassword = [[UITextField alloc] initWithFrame:CGRectMake(45, 5, mainWidth - 80, 34)];
    txtRegPassword.backgroundColor = [UIColor whiteColor];
    txtRegPassword.font = [UIFont systemFontOfSize:15];
    txtRegPassword.placeholder = @"注册码密码";
    txtRegPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    //txtPhone.keyboardType = UIKeyboardTypeNumberPad;
    txtRegPassword.keyboardType = UIKeyboardTypeAlphabet;
    txtRegPassword.returnKeyType = UIReturnKeyDefault;
    txtRegPassword.delegate = self;
    [vvv6 addSubview:txtRegPassword];
    
    
    
    
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    
    
    
    UIButton* btnReg = [[UIButton alloc] initWithFrame:CGRectMake(16, 310, mainWidth - 32, 44)];
    btnReg.layer.cornerRadius = 5;
    btnReg.backgroundColor = NAVBAR_COLOR;
    [btnReg setTitle:@"注册" forState:UIControlStateNormal];
    [btnReg addTarget:self action:@selector(didRegAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReg];
    
}



-(void)didRegAction{
    if(txtUser.text.length==0){
        [[XBToastManager ShardInstance] showtoast:@"请输入账号"];
        return;
    }
    else if(txtPwd.text.length==0){
        [[XBToastManager ShardInstance] showtoast:@"请输入密码"];
        return;
    }
    else if(txtConfirmPwd.text.length==0){
        [[XBToastManager ShardInstance] showtoast:@"请输入确认密码"];
        return;
    }
    else if(txtEmail.text.length==0){
        [[XBToastManager ShardInstance] showtoast:@"请输入邮箱"];
        return;
    }else if(txtRegCode.text.length==0){
        [[XBToastManager ShardInstance] showtoast:@"请输入注册码"];
        return;
    }else if(txtRegPassword.text.length==0){
        [[XBToastManager ShardInstance] showtoast:@"请输入注册密码"];
        return;
    }
    else if(![txtConfirmPwd.text isEqualToString:txtPwd.text]) {
        [[XBToastManager ShardInstance] showtoast:@"两次输入密码不一致"];
        return;
    }
    
    
    [[XBToastManager ShardInstance] showprogress];
    
    BERegisterModel *api = [[BERegisterModel alloc] initWithUsername:txtUser.text password:txtPwd.text email:txtEmail.text regCode:txtRegCode.text regPassword:txtRegPassword.text deviceId:[SetDevieceUUID getDeviceUUID]];
    //RegisterModel *api = [[RegisterModel alloc] initWithUsername:txtUser.text password:txtPwd.text email:txtEmail.text];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        [[XBToastManager ShardInstance] hideprogress];
        NSLog(@"succeed");
        
        NSLog(@"收获的数据:%@",api.responseString);
        
        
        [[XBToastManager ShardInstance] hideprogress];
        NSData *jsonData = [api.responseString
                            dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"解析后的数据:%@", root);
        
        
        
        NSString *state = [root objectForKey:@"state"];
        
        if([state intValue]==1){
            
            NSString *info = [root objectForKey:@"info"];
            NSLog(@"info:%@",info);
            NSString *token = [root objectForKey:@"result"];
            
            NSLog(@"token:%@",token);
            
            [[NSUserDefaults standardUserDefaults] setObject:txtUser.text forKey:kLoginUsername];
            [[NSUserDefaults standardUserDefaults] setObject:txtPwd.text forKey:kLoginUserpwd];
                        [[NSUserDefaults standardUserDefaults] setObject:token forKey:kToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
 
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController =[self setRootVC];
            

            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            

            
            
        }else{
            NSString *info = [root objectForKey:@"info"];
            
            [[XBToastManager ShardInstance] showtoast:info];
        }
    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"连接失败,请稍后重试"];
        
    }];
    
}


#pragma mark -
#pragma mark 解决虚拟键盘挡住UITextField的方法
- (void)keyboardWillShow:(NSNotification *)noti
{
    //键盘输入的界面调整
    //键盘的高度
    
    NSLog(@"keyboard show");
    float height = 216.0;
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 64.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.superview.frame;
    NSLog(@"当前位置%f",frame.origin.y);
    NSLog(@"视图%f",self.view.frame.size.height);
    int offset = frame.origin.y+40 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
#pragma mark -

#pragma mark -
#pragma mark 触摸背景来关闭虚拟键盘
-(void)backgroundTap
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 64.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    [txtUser resignFirstResponder];
     [txtEmail resignFirstResponder];
     [txtPwd resignFirstResponder];
     [txtConfirmPwd resignFirstResponder];
    [txtRegCode resignFirstResponder];
    [txtRegPassword resignFirstResponder];
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
    
    return tabBarController;
}



@end
