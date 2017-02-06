//
//  MSZXGuardKeyboard.h
//  MSZXFramework
//
//  Created by MSZX on 15/2/2.
//  Copyright (c) 2015年 wenyanjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PassGuardCtrl.h"


@class MSZXGuardKeyboard;
@protocol MSZXGuardKeyboardViewDelegate <NSObject>

@optional
-(void)guardkeyboardView:(MSZXGuardKeyboard*)guardkeyboardView doneWithValue:(NSString *)value;
-(void)guardkeyboardView:(MSZXGuardKeyboard*)guardkeyboardView dismissWithDefaultValue:(NSString *)value;

@end

@interface MSZXWebPassKeyboardConfig : NSObject

@property(nonatomic, strong)  NSString *guardRandomnumber;
@property(nonatomic, strong)  NSString *callBack ;
@property(nonatomic, strong)  NSString *maxlen ;
@property(nonatomic, strong)  NSString *minlen ;
@property(nonatomic, strong)  NSString *errorMsg ;
@property(nonatomic, strong)  NSString *nullMsg ;
@property(nonatomic, strong)  NSString *state ;

-(id)initWithDictory:(NSDictionary *)dict;

@end


@interface MSZXGuardKeyboard : UIView<DoneDelegate>

/**
 *  回调函数
 */
@property(nonatomic, strong) NSString *callback;

/**
 *  键盘委托协议
 */
@property(nonatomic, weak) id<MSZXGuardKeyboardViewDelegate> delegate;

/**
 * 通过frame大小和passConfig来初始化安保键盘
 */
-(id)initWithFrame:(CGRect)frame passConfig:(MSZXWebPassKeyboardConfig *)passConfig;

/**
 *  显示安保键盘
 */
-(void)showGuardKeyBoard;

@end
