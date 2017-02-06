//
//  MSZXWebViewController.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-2.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXBaseViewController.h"
#import "MSZXWebBrowserView.h"
#import "IRequestKeyDefine.h"

@interface MSZXWebViewController : MSZXBaseViewController <MSZXWebBrowserViewDelegate>

/**
 *  webView
 */
@property (nonatomic, strong) MSZXWebBrowserView *webView;
/**
 *  业务ID
 */
@property (nonatomic, strong) NSDictionary *urlPara;
/**
 *  具体业务的特定参数
 */
@property (nonatomic, assign) RequestKeyID requestKey;

/**
 *  页面URL
 */
@property (nonatomic, strong) NSString *pageUrl;

/**
 *  注册业务方法的js回调center
 *
 *  @param jsCenter js回调center
 */
- (void)registBusinessJSCenter:(MSZXWebviewBaseJSInvokeCenter *)jsCenter;

/**
 *  刷新Web页面
 */
- (void)reloadPage;

-(NSString *)evalJs:(NSString *)strJs;

@end
