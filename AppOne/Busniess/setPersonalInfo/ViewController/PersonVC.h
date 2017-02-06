//
//  PersonVC.h
//  AppOne
//
//  Created by lile on 15/8/19.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "OneBaseVC.h"

@protocol ChangeTextViewDelegate <NSObject>

- (void) textEntered:(NSString*)text;

@end

@interface PersonVC : OneBaseVC<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,copy) NSString *tittle;
@property(nonatomic,copy) NSString *inputValue;
@property (strong, readwrite, nonatomic) NSString *detailType; //01 昵称  02邮箱 03 手机号
@property (strong, readwrite, nonatomic) NSString *tableType;//01 单列表输入 02 选择器
@property (strong, readwrite, nonatomic) NSArray *option;

@property (assign, nonatomic) id<ChangeTextViewDelegate> delegate;
@end
