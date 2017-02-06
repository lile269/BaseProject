//
//  addFavoriteModel.h
//  AppOne
//
//  Created by lile on 15/7/27.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "YTKRequest.h"

@interface addFavoriteModel : YTKRequest
- (id)initWithUsername:(NSString *)username token:(NSString *)token course_id:(NSString *)course_id  id:(NSNumber*)id do_favorite:(NSNumber*)do_favorite;
@end
