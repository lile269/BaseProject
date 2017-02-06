//
//  AFURLRequestSerialization+HttpBody.m
//  MSZX
//
//  Created by wenyanjie on 14-11-21.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "AFURLRequestSerialization+HttpBody.h"

@implementation AFHTTPRequestSerializer (HttpBody)

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                     httpBody:(NSString *)jsonBody
                                     error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(method);
    NSParameterAssert(URLString);
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSParameterAssert(url);
    
    NSString* requestUrlString = [NSString stringWithFormat:@"%@",url];
	NSMutableArray *parametersArray = [NSMutableArray array];
	for (NSString *key in parameters) {
		[parametersArray addObject:[NSString stringWithFormat:@"%@=%@", key, [parameters valueForKey:key]]];
	}
	NSString* paramString = [parametersArray componentsJoinedByString:@"&"];
    requestUrlString = [requestUrlString stringByAppendingString:paramString];
    NSURL * requestUrl = [NSURL URLWithString:requestUrlString];
    
    NSMutableURLRequest *mutableRequest = [[NSMutableURLRequest alloc] initWithURL:requestUrl];
    mutableRequest.HTTPMethod = method;
    mutableRequest.allowsCellularAccess = self.allowsCellularAccess;
    mutableRequest.cachePolicy = self.cachePolicy;
    mutableRequest.HTTPShouldHandleCookies = self.HTTPShouldHandleCookies;
    mutableRequest.HTTPShouldUsePipelining = self.HTTPShouldUsePipelining;
    mutableRequest.networkServiceType = self.networkServiceType;
    mutableRequest.timeoutInterval = self.timeoutInterval;
    
    NSMutableURLRequest *request = [mutableRequest mutableCopy];
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    
    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
    [mutableRequest setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    [mutableRequest setHTTPBody:[jsonBody dataUsingEncoding:self.stringEncoding]];
    
	return mutableRequest;
}

- (void)setAFNetworkingTimeout:(NSInteger)aTimeInternal
{
    self.timeoutInterval = aTimeInternal;
}

@end
