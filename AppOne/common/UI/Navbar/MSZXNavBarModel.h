//
//  MSZXNavBarModel.h
//  MSZXFramework
//
//  Created by wenyanjie on 14-12-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSZXBarButtonModel : NSObject

@property BOOL exist;
@property (nonatomic, copy) NSString *showNo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *func;

-(id)initWithDict:(NSDictionary*)paraDict;

@end

@interface MSZXNavBarModel : NSObject

@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * theFunc;
@property(nonatomic, strong) MSZXBarButtonModel * leftButton;
@property(nonatomic, strong) MSZXBarButtonModel * rightButton;

-(id)initWithDict:(NSDictionary*)paraDict;

@end
