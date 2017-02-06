//
//  QuestionDetailVC.h
//  AppOne
//
//  Created by lile on 15/9/15.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "OneBaseVC.h"
#import "QCheckBox.h"
#import "MZTimerLabel.h"
#import "AnswerTextField.h"
#import "LVRecordTool.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>
#import <sys/utsname.h>

@interface QuestionDetailVC : UIViewController<QCheckBoxDelegate,UIScrollViewDelegate,UITextFieldDelegate,LVRecordToolDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate>

@property (nonatomic,assign)  NSInteger questionIndex;
@property(nonatomic,retain)   NSURLResponse * response;//用来获取下载的文件的文件名
@property (nonatomic,strong)  MZTimerLabel *counterLabel;
@property(nonatomic,copy)      NSString *detailType; ////01 练习 02 收藏 03 错题  04 题目分析
@property(nonatomic,strong) UIScrollView * lazyScrollView;
@property(nonatomic,assign) CGFloat originContentY;
@property (nonatomic,strong) AnswerTextField *textField;
-(void)showQuestionExplainAction;
-(void)dismissKeybordAction;
-(void)dismissKeybordActionRightNow;
-(void)addExpalinView;
-(void)removeExpalinView;
-(void)showAudioAction;
-(void)pauseAdudioAction;
-(BOOL)IsExplainViewShow;
-(void)playUserfulExpressionAudio;
-(void)pauseUserfulExpressionAudio;
@end
