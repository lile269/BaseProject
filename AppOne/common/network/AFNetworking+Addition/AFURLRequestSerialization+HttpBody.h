//
//  AFURLRequestSerialization+HttpBody.h
//  MSZX
//
//  Created by wenyanjie on 14-11-21.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "AFURLRequestSerialization.h"

/**
 *  由于Tesla后台需要POST请求的参数放到http的报文体里边，因此扩展AFNetworking类库的AFHTTPRequestSerializer方法
 */


@interface AFHTTPRequestSerializer (HttpBody)

/**
 *  由于Tesla后台需要POST请求的参数放到http的报文体里边，因此扩展AFNetworking类库的AFHTTPRequestSerializer方法
 *
 *  @param method     网络请求方法
 *  @param URLString  网络请求地址
 *  @param parameters 参数
 *  @param jsonBody   json报文体
 *  @param error      错误描述符
 *
 *  @return 网络Request
 */
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                  httpBody:(NSString *)jsonBody
                                     error:(NSError *__autoreleasing *)error;

/**
 *  设定网络超时时间
 *
 *  @param timeInternal 超时时间
 */
- (void)setAFNetworkingTimeout:(NSInteger)aTimeInternal;
@end
