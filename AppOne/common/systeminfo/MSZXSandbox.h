//
//  MSZXSandbox.h
//  MSZX
//
//  Created by wenyanjie on 14-3-25.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSZXSandbox : NSObject

@property (nonatomic, readonly) NSString *	appPath;
@property (nonatomic, readonly) NSString *	docPath;
@property (nonatomic, readonly) NSString *	libPrefPath;
@property (nonatomic, readonly) NSString *	libCachePath;
@property (nonatomic, readonly) NSString *	tmpPath;

+ (MSZXSandbox *)sharedInstance;

/**
 *  获得程序目录
 *
 *  @return 程序目录，不能存任何东西
 */
+ (NSString *)appPath;

/**
 *  获得文档目录
 *
 *  @return 文档目录，需要ITUNES同步备份的数据存这里
 */
+ (NSString *)docPath;

/**
 *  获得配置目录
 *
 *  @return 配置目录，配置文件存这里
 */
+ (NSString *)libPrefPath;

/**
 *  获得缓存目录
 *
 *  @return 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
 */
+ (NSString *)libCachePath;	// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除

/**
 *  获得缓存目录
 *
 *  @return 缓存目录，APP退出后，系统可能会删除这里的内容
 */
+ (NSString *)tmpPath;

/**
 *  如果目录不存在，则创建目录
 *
 *  @param path 目录
 *
 *  @return 创建目录是否成功
 */
+ (BOOL)touch:(NSString *)path;

/**
 *  如果文件不存在，则创建文件
 *
 *  @param file 文件
 *
 *  @return 创建文件是否成功
 */
+ (BOOL)touchFile:(NSString *)file;

@end
