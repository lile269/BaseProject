//
//  SetDevieceUUID.h
//  test
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 HJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetDevieceUUID : NSObject

+(NSString*)getDeviceUUID;

+(void)setDeviceUUID:(NSString *)strUdid;

+ (void) clearUUID;

@end
