//
//  MSZXNetwork.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-24.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXNetwork.h"
#import "XMLParser.h"
#import "MSZXJSONKit.h"
#import "AFHTTPRequestOperationManager+HttpBody.h"
#import "MSZXNetworkIndicator.h"

@interface MSZXNetwork ()

@property(nonatomic, strong)AFHTTPRequestOperation *operation;
@property(nonatomic, assign)NSInteger timeInternal;

@end

@implementation MSZXNetwork

+ (MSZXNetwork *)sharedInstance
{
    static MSZXNetwork* _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MSZXNetwork alloc]init];
    });
    return _sharedInstance;
}

- (MSZXNetwork *)init
{
    self = [super init];
    if (self) {
        //
        self.operation = nil;
    }
    return self;
}

- (void)getHTMLDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(MSZXSuccessResponseBlock)success
                   failure:(MSZXFailResponseBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operation = [manager GET:URLString
                       parameters:parameters
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              //-.NSString* dataString = [[NSString alloc]initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
                              NSDictionary* parseData = [NSDictionary dictionaryFromJSONData:(NSData *)responseObject];//-.[dataString objectFromJSONString];
                              success(operation, parseData);
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              failure(error);
                          }];
}

- (void)getJSONDataWithUrl:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(MSZXSuccessResponseBlock)success
                   failure:(MSZXFailResponseBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.operation = [manager GET:URLString
                       parameters:parameters
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              success(operation, responseObject);
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              failure(error);
                          }];
}

- (void)getXMLDataWithUrl:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                  success:(MSZXSuccessResponseBlock)success
                  failure:(MSZXFailResponseBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.operation = [manager GET:URLString
                       parameters:parameters
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              NSData* responseData = [NSData dataWithData:(NSData *)(responseObject)];
                              XMLParser  *xmlParser = [[XMLParser alloc] init];
                              [xmlParser parseData:responseData
                                           success:^(id parsedData) {
                                               success(operation, parsedData);
                                           }
                                           failure:^(NSError *error) {
                                               failure(error);
                                           }];
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              failure(error);
                          }];
}

- (void)getImageDataWithUrl:(NSString *)URLString
                 parameters:(NSDictionary *)parameters
                    success:(MSZXSuccessResponseBlock)success
                    failure:(MSZXFailResponseBlock)failure
{
    [[MSZXNetworkIndicator sharedInstance] startWebviewIndicator];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setAFNetworkingTimeout:10];
    [manager GET:URLString
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [[MSZXNetworkIndicator sharedInstance] stopWebviewIndicator];
             
             UIImage* image = [UIImage imageWithData:(NSData *)responseObject];
             success(operation,image);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [[MSZXNetworkIndicator sharedInstance] stopWebviewIndicator];
             
             failure(error);
         }];
}

- (void)postTeslaDataWithUrl:(NSString*)URLString
                    httpBody:(NSString*)jsonBody
                     success:(MSZXSuccessResponseBlock)success
                     failure:(MSZXFailResponseBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setAFNetworkingTimeout:self.timeInternal];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.operation = [manager POST:URLString
                        parameters:nil
                              body:jsonBody
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               success(operation, responseObject);
                           }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               failure(error);
                           }];
}

- (void)postMultiFormDataWithUrl:(NSString*)URLString
                        FormData:(NSData*)data
                         success:(MSZXSuccessResponseBlock)success
                         failure:(MSZXFailResponseBlock)failure
{
    NSMutableURLRequest *request = nil;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setAFNetworkingTimeout:self.timeInternal];
    request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST"
                                                              URLString:URLString
                                                             parameters:nil
                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                  [formData appendPartWithFileData:data
                                                                              name:@"file"
                                                                          fileName:@"file.jpeg"
                                                                          mimeType:@"image/jpeg"];
                                              }
                                                                  error:nil];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request
                                                                         success:success
                                                                         failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                                                             failure(error);
                                                                         }];
    [manager.operationQueue addOperation:operation];
}

-(void)setValidationTimeInternal:(NSInteger)time
{
    self.timeInternal = time;
}

- (void)cancelAFURLRequest
{
    if (self.operation != nil) {
        if (![self.operation isCancelled]) {
            [self.operation cancel];
            self.operation = nil;
        }
    }
}

@end
