//
//  MSZXWebViewController.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-2.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXWebViewController.h"
#import "MSZXWebService.h"
#import "MSZXWebviewJSManager.h"
#import "MSZXPublicJSCenter.h"
#import "MSZXGuardKeyboard.h"


@interface MSZXWebViewController () <PublicJSCenterDelegate,MSZXGuardKeyboardViewDelegate>

@property (nonatomic, strong) NSString *navLeftButtonFunc;
@property (nonatomic, strong) NSString *navRightButtonFunc;

- (void)loadPage;

- (void)executableJScode:(NSDictionary *)dict;
- (void)settingNavigationBar:(NSString *)eventName;

- (void)leftNavBarButtonClick;
- (void)rightNavBarButtonClick;
- (void)backToTop;

@end

@implementation MSZXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWebview];
    
    // 优先加载配置的URL
    if (![NSString strNilOrEmpty:self.pageUrl])
    {
        [self loadPage];
    }
    // URL没有配置时，尝试读取业务ID配置对应的URL
    else if (self.requestKey != MSZX_NONE)
    {
        NSString *urlString = [[MSZXWebService sharedInstance] requestUrlStringWithKey:self.requestKey param:self.urlPara];
        self.pageUrl = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        [self loadPage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Public methods
- (void)reloadPage
{
    [self loadPage];
}

- (void)registBusinessJSCenter:(MSZXWebviewBaseJSInvokeCenter *)jsCenter
{
    [[MSZXWebviewJSManager sharedInstance] registerJSCenter:jsCenter];
}

#pragma mark - Private methods
- (void)initWebview
{
    CGRect viewFrame = [self contentViewFrame];
    MSZXWebBrowserView *tmpWebView = [[MSZXWebBrowserView alloc] initWithFrame:viewFrame];
    tmpWebView.delegate = self;
    self.webView = tmpWebView;
    [self.view addSubview:self.webView];
    
    // 这个单例的用法，要求处理公共方法的webview不能同时存在多个
    [MSZXPublicJSCenter sharedInstance].JSCenterDelegate = self;
}

- (void)loadPage
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.pageUrl ]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:WEBPAGE_TIMEOUT];
    [self.webView loadRequest:request];
}

- (void)leftNavBarButtonClick
{
    [self.webView stringByEvaluatingJavaScriptFromString:self.navLeftButtonFunc];
}

- (void)rightNavBarButtonClick
{
    [self.webView stringByEvaluatingJavaScriptFromString:self.navRightButtonFunc];
}

- (void)backToTop
{
    if(self.navigationController)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - PublicJSCenterDelegate
-(void)executableJScode:(NSDictionary *)dict
{
    NSString *eventCode = dict[@"evtCode"];
    NSString *eventName = dict[@"evtName"];
    
    // 更新导航栏的状态
    if ([eventCode isEqualToString:@"02"])
    {
        [self settingNavigationBar:eventName];
    }
    else if ([eventCode isEqualToString:@"A2"])
    {
        [self backToTop];
    }
    // 弹出安保全键盘
    else if ([eventCode isEqualToString:@"GUA2"]){
       [self initLoginSecurityNumberKeyboard:eventName];
   }
}

//默认安保键盘 GUA2
-(void)initLoginSecurityNumberKeyboard:(NSString *)eventName
{
    //执行前台js函数，获取到json格式参数字符串
    NSString *jsonstr = [self evalJs:eventName];
    //将参数以UTF-8格式转为 NSDictionary类型
    NSDictionary *dict = [NSDictionary dictionaryFromJSONData:[jsonstr dataUsingEncoding:NSUTF8StringEncoding]];
    //将NSDictionary类型参数 封装为参数对象
    MSZXWebPassKeyboardConfig *passConfig=[[MSZXWebPassKeyboardConfig alloc] initWithDictory:dict];
   
    MSZXGuardKeyboard *guardKeyboard = [[ MSZXGuardKeyboard alloc] initWithFrame:CGRectZero passConfig:passConfig];
    
    guardKeyboard.delegate=self;
    
    [guardKeyboard showGuardKeyBoard];
}

//JavaScript
-(NSString *)evalJs:(NSString *)strJs{
    NSString *result = [self.webView  stringByEvaluatingJavaScriptFromString:strJs];
    return result;
}

#pragma mark - Public Webview Methods
// 设置NavigationBar
- (void)settingNavigationBar:(NSString *)eventName{
    
    NSString *strToolBarInfo = [self.webView stringByEvaluatingJavaScriptFromString:eventName];
    
    NSDictionary *navbarDict = nil;
    if (![NSString strNilOrEmpty:strToolBarInfo])
    {
        navbarDict = [NSDictionary dictionaryFromJSONData:[strToolBarInfo dataUsingEncoding:NSUTF8StringEncoding]];
    }
    MSZXNavBarModel * navbarModel = [[MSZXNavBarModel alloc] initWithDict:navbarDict];
    self.navBarView.title = navbarModel.title;
    if (navbarModel.leftButton.exist)
    {
        self.navLeftButtonFunc = navbarModel.leftButton.func;
        MSZXBarButtonItem * _tmpItem=[[MSZXBarButtonItem alloc] initBackWithTarget:self
                                                                            action:@selector(leftNavBarButtonClick)];
        self.navBarView.leftButtonItem = _tmpItem;
    }
    else
    {
        self.navLeftButtonFunc = navbarModel.leftButton.func;
        MSZXBarButtonItem * _tmpItem = [[MSZXBarButtonItem alloc] initBackWithTarget:self
                                                                              action:@selector(backToTop)];
        self.navBarView.leftButtonItem = _tmpItem;
        
    }

    if (navbarModel.rightButton.exist)
    {
        self.navRightButtonFunc = navbarModel.rightButton.func;
        self.navBarView.rightButtonItem = [[MSZXBarButtonItem alloc] initWithTitle:navbarModel.rightButton.name
                                                                            target:self
                                                                            action:@selector(rightNavBarButtonClick)];
    }
    else
    {
        self.navBarView.rightButtonItem = nil;
    }
}

/**
 *  密码输入完后的回调函数
 *
 *  @param guardkeyboardView 安保键盘视图对象
 *  @param value    返回的值
 */
-(void)guardkeyboardView:(MSZXGuardKeyboard*)guardkeyboardView doneWithValue:(NSString *)value{
    NSString *fullCallback = [NSString stringWithFormat:@"%@('%@')",guardkeyboardView.callback,value];
    //调用客户端前台页面中的JS函数
    [self evalJs:fullCallback]; 
}
-(void)guardkeyboardView:(MSZXGuardKeyboard*)guardkeyboardView dismissWithDefaultValue:(NSString *)value{
    
}

@end
