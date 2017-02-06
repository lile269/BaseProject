//
//  QuestionResultVC.h
//  AppOne
//
//  Created by lile on 15/9/28.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "OneBaseVC.h"

@interface QuestionResultVC : OneBaseVC
@property(nonatomic,assign) NSInteger completeQuestNum;
@property(nonatomic,assign) NSInteger wrongQuestNum;
@property(nonatomic,assign) NSInteger rightQuestNum;
@property(nonatomic,assign) NSInteger donotNumber;
@property(nonatomic,assign) NSInteger correctRate;
@property(nonatomic,assign) NSInteger allQuestNum;
@property(nonatomic,assign) NSString *counterTime;
@end
