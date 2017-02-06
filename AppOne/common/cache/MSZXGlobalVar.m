//
//  MSZXGlobalVar.m
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-29.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "MSZXGlobalVar.h"
#import "MSZXSecurityUtil.h"

@implementation MSZXGlobalVar

+ (MSZXGlobalVar *)sharedInstance
{
    static MSZXGlobalVar *_globalVarInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _globalVarInstance = [[MSZXGlobalVar alloc] init];
    });
    return _globalVarInstance;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.aesToken = [MSZXSecurityUtil generateAESKey];
    }
    
    return self;
}

-(void)clearGlobalVarSession
{
    if (self.loginSession) {
        self.loginSession = nil;
    }

    if (self.transferOutData) {
        self.transferOutData = nil;
    }
    
    if (self.transferInData) {
        self.transferInData = nil;
    }
    
    self.aesToken = [MSZXSecurityUtil generateAESKey];
}

@end
