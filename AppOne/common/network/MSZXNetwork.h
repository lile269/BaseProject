//
//  MSZXNetwork.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFURLRequestSerialization+HttpBody.h"
#import "AFHTTPRequestOperationManager+HttpBody.h"
#import "MSZXNetworkIndicator.h"

typedef void (^MSZXSuccessResponseBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^MSZXFailResponseBlock)(NSError* error);

// JSON--WebServices
@interface MSZXNetwork : NSObject
{
    
}

+ (MSZXNetwork *)sharedInstance;

/**
 *  GET请求HTML页面
 *
 *  @param URLString  请求URL地址
 *  @param parameters 请求参数
 *  @param success    请求成功的处理函数
 *  @param failure    请求失败的处理函数
 */
- (void)getHTMLDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(MSZXSuccessResponseBlock)success
                   failure:(MSZXFailResponseBlock)failure;

/**
 *  GET请求json数据
 *
 *  @param URLString  请求URL地址
 *  @param parameters 请求参数
 *  @param success    请求成功的处理函数
 *  @param failure    请求失败的处理函数
 */
- (void)getJSONDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(MSZXSuccessResponseBlock)success
                   failure:(MSZXFailResponseBlock)failure;

/**
 *  GET请求XML数据
 *
 *  @param URLString  请求URL地址
 *  @param parameters 请求参数
 *  @param success    请求成功的处理函数
 *  @param failure    请求失败的处理函数
 */
- (void)getXMLDataWithUrl:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                  success:(MSZXSuccessResponseBlock)success
                  failure:(MSZXFailResponseBlock)failure;

/**
 *  GET请求图片
 *
 *  @param URLString  请求URL地址
 *  @param parameters 请求参数
 *  @param success    请求成功的处理函数
 *  @param failure    请求失败的处理函数
 */
- (void)getImageDataWithUrl:(NSString *)URLString
                 parameters:(NSDictionary *)parameters
                    success:(MSZXSuccessResponseBlock)success
                    failure:(MSZXFailResponseBlock)failure;

/**
 *  Tesla后台接受的POST参数放到了报文头才能正确解析，这种方式不满足AFNetworking类库的设计初衷，
 *  为了兼容这种不规范的设计，特添加如下函数处理POST请求
 *
 *  @param URLString 请求URL地址
 *  @param jsonBody  POST请求参数转成的JSON字符串，放到报文头里边处理
 *  @param success   请求成功的处理函数
 *  @param failure   请求失败的处理函数
 */
- (void)postTeslaDataWithUrl:(NSString*)URLString
                    httpBody:(NSString*)jsonBody
                     success:(MSZXSuccessResponseBlock)success
                     failure:(MSZXFailResponseBlock)failure;

/**
 *  将数据以表单的形式上传到服务器
 *
 *  @param URLString 请求URL地址
 *  @param data      上传的表单数据
 *  @param success   请求成功的处理函数
 *  @param failure   请求失败的处理函数
 */
- (void)postMultiFormDataWithUrl:(NSString*)URLString
                        FormData:(NSData*)data
                         success:(MSZXSuccessResponseBlock)success
                         failure:(MSZXFailResponseBlock)failure;
/**
 *  取消AFNetworking的网络请求
 */
-(void)cancelAFURLRequest;

/**
 *  设置网络请求的超时时间
 *
 *  @param time 超时时间
 */
-(void)setValidationTimeInternal:(NSInteger)time;

@end
