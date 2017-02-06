//
//  AFHTTPRequestOperationManager+HttpBody.m
//  MSZX
//
//  Created by wenyanjie on 14-11-21.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "AFHTTPRequestOperationManager+HttpBody.h"
#import "AFURLRequestSerialization+HttpBody.h"

@implementation AFHTTPRequestOperationManager (HttpBody)

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                            body:(NSString *)jsonBody
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST"
                                                                   URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL]absoluteString]
                                                                  parameters:parameters
                                                                    httpBody:jsonBody
                                                                       error:nil];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end
