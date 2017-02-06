//
//  MSZXGlobalVar.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-11-29.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  缓存session信息,减少一次会话中重复的网络数据访问,同时保存部分全局的变量信息
 */
@interface MSZXGlobalVar : NSObject

+ (MSZXGlobalVar *)sharedInstance;

/**
 *  保存服务器登陆session
 */
@property (nonatomic, strong) NSDictionary *loginSession;

/**
 *  保存资金转入信息
 */
@property (nonatomic,strong) NSDictionary *transferInData;

/**
 *  保存资金转出信息
 */
@property (nonatomic,strong) NSDictionary *transferOutData;

/**
 *  AES加解密算法token
 */
@property(nonatomic,strong) NSString *aesToken;

-(void)clearGlobalVarSession;

@end
