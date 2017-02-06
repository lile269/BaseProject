//
//  RegisterVC.m
//  AppOne
//
//  Created by lile on 15/7/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterModel.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *txtUser;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPwd;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@end

@implementation RegisterVC
@synthesize txtUser;
@synthesize txtPwd;
@synthesize txtConfirmPwd;
@synthesize txtEmail;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.parentViewController.navigationItem.title = @"注册";
    // Do any additional setup after loading the view from its nib.
    txtUser.placeholder = @"请输入您的用户名";
    txtUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtUser.font = [UIFont systemFontOfSize:14];

    txtPwd.placeholder = @"请输入您的密码";
    txtPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtPwd.font = [UIFont systemFontOfSize:14];
    txtPwd.secureTextEntry = YES;
    
    txtConfirmPwd.placeholder = @"请再次输入您的密码";
    txtConfirmPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtConfirmPwd.font = [UIFont systemFontOfSize:14];
    txtConfirmPwd.secureTextEntry = YES;
    
    txtEmail.placeholder = @"请输入您的邮箱号";
    txtEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtEmail.font = [UIFont systemFontOfSize:14];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    NSLog(@"register vc dealloc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)clearAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)didRegistAction:(id)sender{
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
    if(txtConfirmPwd.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入确认密码"];
        return;
    }
    if(txtEmail.text.length==0)
    {
        [[XBToastManager ShardInstance] showtoast:@"请输入邮箱"];
        return;
    }
    
    [[XBToastManager ShardInstance] showprogress];
    RegisterModel *api = [[RegisterModel alloc] initWithUsername:txtUser.text password:txtPwd.text email:txtEmail.text];
    
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
            [[XBToastManager ShardInstance] showtoast:@"获取成功"];
            
    
            NSDictionary *result = [root objectForKey:@"result"];
            NSLog(@"result:%@",result);
            
            NSString *info = [root objectForKey:@"info"];
             NSLog(@"info:%@",info);
            NSString *token = [result objectForKey:@"token"];
            
            NSLog(@"token:%@",token);
            [[NSUserDefaults standardUserDefaults] setObject:kToken forKey:kToken];
            
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

@end
