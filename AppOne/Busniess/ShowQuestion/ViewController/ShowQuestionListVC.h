//
//  ShowQuestionListVC.h
//  AppOne
//
//  Created by lile on 15/9/15.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "OneBaseVC.h"
#import <UIKit/UIKit.h>
#import "DMLazyScrollView.h"
#import "MZTimerLabel.h"
#import "QuestionExamPopUpView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>

@interface ShowQuestionListVC :OneBaseVC<DMLazyScrollViewDelegate,UIScrollViewDelegate,AVAudioPlayerDelegate>
@property (nonatomic,copy)  NSString *course_id;
@property (nonatomic,copy)  NSString *exam_id;
@property (nonatomic,copy)  NSString *showType; //01 练习 02 收藏 03 错题  04 题目分析
@property (nonatomic,copy)  MZTimerLabel *counterLabel;
@property (nonatomic,assign) NSInteger timePass;
@property (nonatomic,assign) NSInteger questNumber;
@property (nonatomic,copy)   NSString *tittleName;
@property(nonatomic,retain)   NSURLResponse * response;//用来获取下载的文件的文件名
@end
