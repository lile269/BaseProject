//
//  BERegisterModel.h
//  AppOne
//
//  Created by lile on 15/9/11.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface BERegisterModel : YTKRequest
- (id)initWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email regCode:(NSString*)regCode regPassword:(NSString*)regPassword deviceId:(NSString*)deviceId;
@end

