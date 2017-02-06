//
//  CommonData.m
//  AppOne
//
//  Created by lile on 15/7/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "CommonData.h"
#import "LoginInfoVC.h"

@implementation Commondata

+ (Commondata *)sharedInstance
{
    static Commondata *_resManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _resManager = [[self alloc] init];
    });
    return _resManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        _nickname = nil;
        _sex = nil;
        _birthday = nil;
        _email = nil;
        _telphone = nil;
        _photo = nil;
        _district = nil;
        _exam_time = nil;
        _left_time = nil;
        _passing_percent = nil;
        _examadd = nil;
        _loginState = nil;
        _courseList = nil;
        _photo_url = nil;
        _pointsResult = nil;
        _player = nil;
        _subQuestionArray=nil;
        _questionArray = [[NSMutableArray alloc]initWithCapacity:15];
        _userAnswerArray = [[NSMutableDictionary alloc] initWithCapacity:5];
        _selectResultDic = [[NSMutableDictionary alloc]initWithCapacity:4];
        _questionBootomView = nil;
        _questionTypeArray = nil;
        _commonQuestionHead = [[NSMutableDictionary alloc]initWithCapacity:10];
        _completeBlanksAnswer = [[NSMutableArray alloc]initWithCapacity:10];
    }
    
    return self;
}

- (void)destroy{
    _nickname = nil;
    _sex = nil;
    _birthday = nil;
    _email = nil;
    _telphone = nil;
    _photo = nil;
    _district = nil;
    _exam_time = nil;
    _left_time = nil;
    _passing_percent = nil;
    _examadd = nil;
    _loginState = nil;
    _courseList = nil;
    _photo_url = nil;
    _pointsResult = nil;
    _player = nil;
    _subQuestionArray = nil;
    [_userAnswerArray removeAllObjects];
    _questionBootomView = nil;
    _questionTypeArray = nil;
    [_selectResultDic removeAllObjects];
    [_commonQuestionHead removeAllObjects];
    [_completeBlanksAnswer removeAllObjects];
    
}

-(void)backToLoginVC:(id)currentVC{
    [self destroy];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kLoginUserpwd];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    LoginInfoVC *vc = [[LoginInfoVC alloc] init];
    //
    //
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = nav;
    [currentVC dismissViewControllerAnimated:YES completion:^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = nav;
    }];
    

//    [currentVC presentViewController:nav animated:YES completion:nil];
    

}



@end
