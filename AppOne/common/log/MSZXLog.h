//
//  MSZXLog.h
//  MSZX
//
//  Created by wenyanjie on 14-3-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#ifndef MSZX_MSZXLog_h
#define MSZX_MSZXLog_h
#endif

#define INFO_NEW_FMT(fmt) \
[NSString stringWithFormat:@"[INFO] %s(%d) %@", \
__FUNCTION__, \
__LINE__, \
fmt]

#define DEBUG_NEW_FMT(fmt) \
[NSString stringWithFormat:@"[DEBUG] %s(%d) %@", \
__FUNCTION__, \
__LINE__, \
fmt]

#define WARNING_NEW_FMT(fmt) \
[NSString stringWithFormat:@"[WARNING] %s(%d) %@", \
__FUNCTION__, \
__LINE__, \
fmt]

#define ERROR_NEW_FMT(fmt) \
[NSString stringWithFormat:@"[ERROR] %s(%d) %@", \
__FUNCTION__, \
__LINE__, \
fmt]


// 控制各模块的LOG宏

// Test模块的log
#define TEST_LOG

#ifdef TEST_LOG
#define TestLog_i(fmt,...) NSLog(INFO_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define TestLog_d(fmt,...) NSLog(DEBUG_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define TestLog_w(fmt,...) NSLog(WARNING_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define TestLog_e(fmt,...) NSLog(ERROR_NEW_FMT(fmt),##__VA_ARGS__,nil)
#else
#define TestLog_i(fmt,...)
#define TestLog_d(fmt,...)
#define TestLog_w(fmt,...)
#define TestLog_e(fmt,...)
#endif

// UIWebView的log
#define WEBVIEW_LOG

#ifdef WEBVIEW_LOG
#define WebViewLog_i(fmt,...) NSLog(INFO_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define WebViewLog_d(fmt,...) NSLog(DEBUG_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define WebViewLog_w(fmt,...) NSLog(WARNING_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define WebViewLog_e(fmt,...) NSLog(ERROR_NEW_FMT(fmt),##__VA_ARGS__,nil)
#else
#define WebViewLog_i(fmt,...)
#define WebViewLog_d(fmt,...)
#define WebViewLog_w(fmt,...)
#define WebViewLog_e(fmt,...)
#endif

// Network Reachability的log
#define Reachability_LOG

#ifdef Reachability_LOG
#define ReachabilityLog_i(fmt,...) NSLog(INFO_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define ReachabilityLog_d(fmt,...) NSLog(DEBUG_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define ReachabilityLog_w(fmt,...) NSLog(WARNING_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define ReachabilityLog_e(fmt,...) NSLog(ERROR_NEW_FMT(fmt),##__VA_ARGS__,nil)
#else
#define ReachabilityLog_i(fmt,...)
#define ReachabilityLog_d(fmt,...)
#define ReachabilityLog_w(fmt,...)
#define ReachabilityLog_e(fmt,...)
#endif


// Network 网络服务请求的log
#define WebService_LOG

#ifdef WebService_LOG
#define WebServiceLog_i(fmt,...) NSLog(INFO_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define WebServiceLog_d(fmt,...) NSLog(DEBUG_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define WebServiceLog_w(fmt,...) NSLog(WARNING_NEW_FMT(fmt),##__VA_ARGS__,nil)
#define WebServiceLog_e(fmt,...) NSLog(ERROR_NEW_FMT(fmt),##__VA_ARGS__,nil)
#else
#define WebServiceLog_i(fmt,...)
#define WebServiceLog_d(fmt,...)
#define WebServiceLog_w(fmt,...)
#define WebServiceLog_e(fmt,...)
#endif
