//
//  AFHTTPRequestOperationManager+HttpBody.h
//  MSZX
//
//  Created by wenyanjie on 14-11-21.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface AFHTTPRequestOperationManager (HttpBody)

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                            body:(NSString *)jsonBody
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
