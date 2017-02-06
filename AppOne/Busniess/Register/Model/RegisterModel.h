//
//  RegisterModel.h
//  AppOne
//
//  Created by lile on 15/7/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface RegisterModel : YTKRequest
- (id)initWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email;
@end
