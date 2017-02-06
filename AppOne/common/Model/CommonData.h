//
//  CommonData.h
//  AppOne
//
//  Created by lile on 15/7/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>

@interface Commondata : NSObject

@property (nonatomic,copy) NSString *loginState;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *telphone;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *district;
@property (nonatomic,copy) NSString *exam_time;
@property (nonatomic,copy) NSString *left_time;
@property (nonatomic,copy) NSString *passing_percent;
@property (nonatomic,copy) NSString *examadd;
@property (nonatomic,copy) NSString *photo_url;
//课程信息
@property (nonatomic,copy) NSArray *courseList;

//课程信息选项

@property (nonatomic,copy) NSArray *pointsResult;


//试题信息

@property (nonatomic,copy) NSMutableDictionary *commonQuestionHead;
@property (nonatomic,copy) NSMutableArray *questionArray;
@property (nonatomic,copy) NSArray *subQuestionArray;

//答题信息
@property (nonatomic,copy) NSMutableDictionary *userAnswerArray;

//选项信息

@property (nonatomic,copy) NSMutableDictionary *selectResultDic;

//填空信息

@property (nonatomic,copy) NSMutableArray *completeBlanksAnswer;

//题型信息

@property (nonatomic,copy) NSArray *questionTypeArray;

//底部视图 01 顺序或自定义 02 考试 03 收藏 04 错题
@property (nonatomic,copy) NSString *questionBootomView;

//纪录键盘位移
@property (nonatomic,assign) BOOL isAdjustKeyboard;
@property (nonatomic,assign) CGFloat orginalWidth;
@property (nonatomic,assign) CGFloat orginalHeight;
@property (nonatomic,assign) CGFloat orginalOffset;

//记录音频播放器
@property(nonatomic,strong)AVAudioPlayer *player ;

//记录跳转index
@property(nonatomic,assign)NSInteger selectedIndex;

+ (Commondata *)sharedInstance;
- (void)destroy;
-(void)backToLoginVC:(id)currentVC;

@end


