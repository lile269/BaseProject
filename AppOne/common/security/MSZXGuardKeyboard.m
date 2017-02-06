//
//  MSZXGuardKeyboard.m
//  MSZXFramework
//
//  Created by MSZX on 15/2/2.
//  Copyright (c) 2015年 wenyanjie. All rights reserved.
//

#import "MSZXGuardKeyboard.h"

#define Cancel_ButtonItem @"取消"
#define Submit_ButtonItem @"确定"

@implementation MSZXWebPassKeyboardConfig

-(id)initWithDictory:(NSDictionary *)dict {
    self = [super init];
    if(self){
        self.guardRandomnumber = [dict objectForKey:@"randomNumber"];
        self.callBack = [dict objectForKey:@"callback"];
        if([dict objectForKey:@"max"]){
           self.maxlen = [dict objectForKey:@"max"];
        }
        else{
             self.maxlen =@"20";
        }
        if([dict objectForKey:@"min"]){
            self.minlen = [dict objectForKey:@"min"];
        }
        else{
            self.minlen = @"6";
        }
        
        self.errorMsg = [dict objectForKey:@"errorMsg"];
        self.nullMsg = [dict objectForKey:@"nullMsg"];
        self.state=[dict objectForKey:@"state"];
    }
    return self;
}

@end

@interface MSZXGuardKeyboard()

@property(nonatomic, assign) NSInteger  inputMinLen;
@property(nonatomic, assign) NSInteger  inputMaxLen;
@property(nonatomic, strong) UIToolbar *toolbar;
@property(nonatomic, strong) PassGuardTextField *passGuardTextField;


//初始化 安保输入框
-(void)initPassGuardTextField:(MSZXWebPassKeyboardConfig *)passConfig;
//初始化 安保键盘相关参数
-(void)initGuardKeyboardByPassConfig:(MSZXWebPassKeyboardConfig *)passConfig;

-(void)initToolbar;

-(void)registerNotification;

@end

@implementation MSZXGuardKeyboard

- (id)initWithFrame:(CGRect)frame passConfig:(MSZXWebPassKeyboardConfig *)passConfig
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.3]];
        [self setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        [self registerNotification];
        //初始化 安保输入文本框
        [self initPassGuardTextField:passConfig];
        //初始化安保键盘相关参数
        [self initGuardKeyboardByPassConfig:passConfig];
        [self initToolbar];
        
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)registerNotification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassGuardCtrlDidBecomeActive) name:@"SetpassGuardTextFieldFous" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];

}

-(void)PassGuardCtrlDidBecomeActive
{
    [_passGuardTextField becomeFirstResponder];
    [self switchGuardKeyBoardState:YES];
}

-(void)KeyBoardWillShow:(NSNotification*)no
{
    NSDictionary* dict = [no userInfo];
    NSValue *value = [dict objectForKey:UIKeyboardFrameBeginUserInfoKey];
    NSNumber *time = [dict objectForKey:UIKeyboardAnimationDurationUserInfoKey];//键盘弹出所用的时间
    NSInteger height = [value CGRectValue].size.height;
    
    [UIView animateWithDuration:[time doubleValue] animations:^{
        CGRect rect = _toolbar.frame;
        rect.origin.y = ScreenHeight-NAV_BAR_HEIGHT-height;
        _toolbar.frame = rect;
    }];
}

-(void)initPassGuardTextField:(MSZXWebPassKeyboardConfig *)passConfig
{
    CGRect passGuardTexFieldRect = CGRectMake(0, 0, 198, 29);

    if (IOS7_OR_LATER) {
        passGuardTexFieldRect = CGRectMake(0, 0, 216, 29);
    }
    self.passGuardTextField = [[PassGuardTextField alloc] initWithFrame:passGuardTexFieldRect];
    self.passGuardTextField.keyboardType = UIKeyboardTypeNumberPad; // 交易密码必须是数字 调数字键盘
    [self.passGuardTextField setFont:[UIFont systemFontOfSize:16]];
    [self.passGuardTextField setBackgroundColor:[UIColor whiteColor]];
    [self.passGuardTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.passGuardTextField setM_bsupportrotate:false];
    [self.passGuardTextField setM_uiapp:[UIApplication sharedApplication]];
   
    [PassGuardTextField initPassGuardCtrl];
    //AES加密密钥
    [self.passGuardTextField setM_strInput1:kSecurityAesKey];
    //RSA加密公钥  新老密钥选择
    NSString *SecuritykeyString = kSecuritykey;
    NSString *secKeyChoseflag = passConfig.state;
    if ([secKeyChoseflag isEqualToString:@"1"]) {
        SecuritykeyString = kSecuritykey1;
    }
    [self.passGuardTextField setM_strInput2:SecuritykeyString];
    
    [self.passGuardTextField setM_strInput3:passConfig.guardRandomnumber];
    
    //支持横竖屏幕
    self.passGuardTextField.m_bsupportrotate=NO;
    [self.passGuardTextField setM_hasstatus:true];
    [self.passGuardTextField setM_strInputR1:@"[0-9A-Za-z]"];
    [self.passGuardTextField setM_strInputR2:@"[0-9A-Za-z]{6,20}"];
   
    [self.passGuardTextField setM_iMaxLen:[passConfig.maxlen intValue]];
    [self.passGuardTextField set_DoneDelegate:self];
   
    
    self.passGuardTextField.placeholder = @"请输入密码";
    self.passGuardTextField.m_isEnablePaste = NO;
    self.passGuardTextField.m_isSpaceNoLogo=true;
     //默认安全键盘 必不可少
    self.passGuardTextField.keyboardType = UIKeyboardTypeDefault;

}

-(void)initGuardKeyboardByPassConfig:(MSZXWebPassKeyboardConfig *)passConfig
{
    if (nil !=passConfig.maxlen)
    {
        self.inputMaxLen=[passConfig.maxlen integerValue];
    }
    if (nil !=passConfig.minlen )
    {
        self.inputMinLen =[passConfig.minlen integerValue];
    }
    if (nil != passConfig.callBack)
    {
        self.callback=passConfig.callBack ;
    }
 
}



-(void)initToolbar{
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight-44, ScreenWidth, 44)];
    _toolbar.barStyle = UIBarStyleBlack;
    
    ///取消按钮
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:Cancel_ButtonItem
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(guardCustomKeyBoardViewDismiss)];
    
    //左边间隔
    UIBarButtonItem *spaceItemLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil
                                                                                   action:nil];
    
    //安保输入框
    UIBarButtonItem *inputItem = [[UIBarButtonItem alloc] initWithCustomView:_passGuardTextField];
    
    //右边间隔
    UIBarButtonItem *spaceItemRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    ///确定按钮
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:Submit_ButtonItem
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(guardCustomKeyBoardViewDone)];
    
    [_toolbar setItems:[NSArray arrayWithObjects:cancelItem,spaceItemLeft,inputItem,spaceItemRight,doneItem, nil]];
    [self addSubview:_toolbar];
    
   


}

-(void)showGuardKeyBoard
{
    UIViewController * viewController = (UIViewController *)self.delegate;
    [viewController.view addSubview:self] ;
    
    [self.passGuardTextField becomeFirstResponder];
    [self switchGuardKeyBoardState:YES];
}

-(void)guardCustomKeyBoardViewDismiss
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SetpassGuardTextFieldFous" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(guardkeyboardView:dismissWithDefaultValue:)]) {
            [self.delegate guardkeyboardView:self dismissWithDefaultValue:nil];
        }
    }
    [self.passGuardTextField resignFirstResponder];
    [self switchGuardKeyBoardState:NO];
}

-(void)guardCustomKeyBoardViewDone
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SetpassGuardTextFieldFous" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    NSString *strPassword = [self.passGuardTextField.text trim];
    
    if ([NSString strNilOrEmpty:strPassword]) {
        [self.passGuardTextField Clean];
    }
    else
    {
        if ((strPassword.length < self.inputMinLen ) || (strPassword.length > self.inputMaxLen )) {
            [self.passGuardTextField Clean];
        }
        else
        {
            NSString *password = [self.passGuardTextField getOutput4];
            // md5 比较密码是否相同
            NSString *md5str = [self.passGuardTextField getOutput2];
            NSInteger textlen = self.passGuardTextField.text.length;
            //判断字母数字组合
            NSArray *passWordInputLevelarray = [self.passGuardTextField getInputLevel];
            
            NSInteger inputlevelvalue = [[passWordInputLevelarray objectAtIndex:0] intValue];
            NSString * doneValue = [NSString stringWithFormat:@"%@|%@|%d|%d",password,md5str,(int)textlen,(int)inputlevelvalue];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(guardkeyboardView:doneWithValue:)]) {
                    [self.delegate guardkeyboardView:self doneWithValue:doneValue];
                }
            }
        }
    }
    [self.passGuardTextField resignFirstResponder];
    [self switchGuardKeyBoardState:NO];
}

#pragma mark - passGuar Delegate
-(void)DoneFun:(id)sender
{
    [sender resignFirstResponder];
    [self switchGuardKeyBoardState:NO];
}

-(void)switchGuardKeyBoardState:(BOOL)bShow
{
    _toolbar.hidden = !bShow;
    self.hidden = !bShow;
}
@end
