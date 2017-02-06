//
//  SetDevieceUUID.m
//  test
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 HJ. All rights reserved.
//

#import "SetDevieceUUID.h"
#import "GSKeychain.h"

@implementation SetDevieceUUID

+(NSString*)getDeviceUUID
{
   //return  @"8979D921-61EF-49AF-A6D7-110E2B827FE5";
    //3C1DABA9-A33A-4931-8903-772D12E973CB   iphone6
   
    GSKeychain * keyWraper = [GSKeychain systemKeychain];
    NSString * strGetUUID = [keyWraper secretForKey:@"BERegister_Deivce_UDID_KEY"];
    
    if (strGetUUID) {
        return strGetUUID;
    }else{
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        [self setDeviceUUID:result];
        return result;
    }

}
+(void)setDeviceUUID:(NSString *)strUdid
{
    GSKeychain * keyWraper = [GSKeychain systemKeychain];
    [keyWraper setSecret:strUdid forKey:@"BERegister_Deivce_UDID_KEY"];
}

+ (void) clearUUID
{
    GSKeychain * keyWraper = [GSKeychain systemKeychain];
    [keyWraper removeSecretForKey:@"BERegister_Deivce_UDID_KEY"];
}

@end
