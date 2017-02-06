//
//  ShowQuestionListVC.m
//  AppOne
//
//  Created by lile on 15/9/15.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "ShowQuestionListVC.h"
#import "getExerciseModel.h"
#import "Animations.h"
#import "addFavoriteModel.h"
#import "CommonData.h"
#import "XBToastManager.h"
#import "commitExcerciseModel.h"
#import "getFavoriteModel.h"
#import "getWrongModel.h"
#import "UIButton+UIButtonExt.h"
#import "QuestionExamPopUpView.h"
#import "removeWrongModel.h"
#import "QuestionDetailVC.h"
#import "QuestionResultVC.h"
#define ARC4RANDOM_MAX	0x100000000

@interface ShowQuestionListVC (){
    NSMutableArray *viewControllerArray;
    DMLazyScrollView * lazyScrollView;
    UIView * pview;
    NSInteger questionIndex;
    NSInteger questionSum;
    UIView* tittleView;
    UILabel * tittleLabel;
    UIView *backGroundView;
    UIView *completeBanksTarView;
    UILabel *uncompleteNumLabel;
    UIScrollView *contentScrollView;
    NSString *audioFileName;
    UIButton *mircoPhoneBtn;
    NSMutableDictionary *commonQuestionHead;
    CGFloat currentY;
    CGFloat allLength;
    NSInteger currentMaxIndex;
    AVAudioPlayer * player;
    NSMutableData * receiveData;
    UIProgressView *progress;
    BOOL backFlag;
    UIButton *audioPlayButton;
    UIButton *checkAnswerButton;
    BOOL playOrNot;
    
}
@property (copy, nonatomic)  UIButton *nextQuestionBtn;
@property (copy, nonatomic)  UIButton *commitExcersiceBtn;
@property (copy, nonatomic)  UIButton *showExplainOrQuestNumBtn;
@property (copy, nonatomic)  UIButton *lastQuestionBtn;
@property (copy, nonatomic)  UIButton *farvoriteBtn;
@property (copy, nonatomic)  UIView *tabView;

@end

@implementation ShowQuestionListVC
@synthesize nextQuestionBtn;
@synthesize commitExcersiceBtn;
@synthesize showExplainOrQuestNumBtn;
@synthesize lastQuestionBtn;
@synthesize farvoriteBtn;
@synthesize tabView;
@synthesize counterLabel;
@synthesize timePass;

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.automaticallyAdjustsScrollViewInsets = NO;//
    self.course_id = @"224";
    self.view.backgroundColor = [UIColor whiteColor];
    backFlag = NO;
    
    commonQuestionHead = [[Commondata sharedInstance]commonQuestionHead];
    __weak typeof (self) wSelf = self;
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        
        [wSelf backToIndex];
    }];
    
    //self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain  target:self action:@selector(backToIndex)];
    [self initTittleView];
    [self initContentView];
    [self initBottomView];
   // self.view.backgroundColor = [UIColor redColor];
   // timePass = 0;
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(changeQuestionPage) name:@"changeQuestionPage" object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(changeUnansweredNum) name:@"changeUnansweredNum" object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(recevieMsgAciton:) name:@"recevieMsgAciton" object:nil];
    player = [[Commondata sharedInstance]player];
    if (player&&[player isPlaying]) {
        [player pause];
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17], NSFontAttributeName,nil]];
    
    
    if (questionIndex > viewControllerArray.count || index < 0) return;
    QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex];
    if (vc.textField) {
        [vc.textField becomeFirstResponder];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    //[self backgroundTap];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:22], NSFontAttributeName,nil]];

}
-(void)viewDidAppear:(BOOL)animated{
    if(![self.showType isEqualToString:@"04"]){
        if(audioPlayButton){
            [audioPlayButton sendActionsForControlEvents:UIControlEventTouchDown];
        }
        
        if (questionIndex > viewControllerArray.count || index < 0) return;
        QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex];
        NSString *type = [commonQuestionHead objectForKey:@"Type"];
        if ([type isEqualToString:@"12"]) {
            [vc playUserfulExpressionAudio];
        }else{
            if (vc.textField) {
                [vc.textField becomeFirstResponder];
            }
        }

    }

}
-(void)dealloc{
    [[[Commondata sharedInstance]selectResultDic]removeAllObjects];
    if (![self.showType isEqualToString:@"04"])
    [[[Commondata sharedInstance]userAnswerArray]removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeQuestionPage" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeUnansweredNum" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"recevieMsgAciton" object:nil];
    player =[[Commondata sharedInstance]player];
    if (player&&[player isPlaying]) {
        [player pause];
    }
    
    [[Commondata sharedInstance]setPlayer:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)recevieMsgAciton:(NSNotification *)notification{

    NSDictionary* user_info = (NSDictionary *)[notification userInfo];
    NSString* info =[user_info objectForKey:@"infoType"];
    NSTimeInterval animationDuration = 0.30f;
   //信号2 音频播放完毕
    if ([info isEqualToString:@"2"]) {
        audioPlayButton.selected = false;
       
        [audioPlayButton removeTarget:self action:@selector(stopAudioAction:) forControlEvents:UIControlEventTouchDown];
        [audioPlayButton addTarget:self
                   action:@selector(playAudioAction:) forControlEvents:UIControlEventTouchDown];
    }else{
    
        [UIView beginAnimations:@"ResizeForTarView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect;
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        //deviceString = @"iPhone4,1";
        if([deviceString isEqual:@"iPhone4,1"]||[deviceString isEqual:@"iPhone3,1"]){
            if ([info isEqualToString:@"1"]) {
                rect = CGRectMake(0, mainHeight-370, mainWidth, 60);
            }else
                rect = CGRectMake(0, mainHeight-170, mainWidth, 60);
        }else{
        
            if ([info isEqualToString:@"1"]) {
                rect = CGRectMake(0, mainHeight-410, mainWidth, 60);
                tabView.frame = CGRectMake(0, mainHeight-350, mainWidth, 60);
            }else{
                rect = CGRectMake(0, mainHeight-170, mainWidth, 60);
                tabView.frame = CGRectMake(0, mainHeight-114, mainWidth, 50);
            }
        }
    
        completeBanksTarView.frame = rect;
        [UIView commitAnimations];
    }
}

-(void)changeQuestionPage{
    if (questionIndex<questionSum-1) {
        [self nextQuestionAction];
    }else
        [[XBToastManager ShardInstance]showtoast:@"题目已经到底"];
    NSString *type = [commonQuestionHead objectForKey:@"Type"];
    NSInteger answeredNum = 0;
    if([type isEqualToString:@"09"]||[type isEqualToString:@"10"]){
        
        NSMutableDictionary *useAnswerArray = [[Commondata sharedInstance]userAnswerArray];
        
        NSArray *keyArray  = [useAnswerArray allKeys];
        if ([keyArray count]>0) {
            NSDictionary *dic = [useAnswerArray objectForKey:keyArray[0]];
            
            NSArray *array = [dic objectForKey:@"ChildAnswers"];
            answeredNum = [array count];
        }else
            answeredNum = 0;
        
        // NSString *temp = [useAnswerArray objectForKey:@"ff"];
        
        
        NSString *unanswerdStr = [NSString stringWithFormat:@"你还有%i题未答",questionSum-answeredNum];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:unanswerdStr];
        [str addAttribute:NSForegroundColorAttributeName value:NAVBAR_COLOR range:NSMakeRange(3,2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, str.length)];
        // [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
        uncompleteNumLabel.attributedText = str;
    }
  
}
- (void)lastQuestionAction{
    
    [lazyScrollView moveByPages:-1 animated:YES];
    
    // [Animations moveRight:qview andAnimationDuration:1.0 andWait:YES andLength:320];
}

-(void)changeUnansweredNum{
   
    NSString *type = [commonQuestionHead objectForKey:@"Type"];
    NSInteger answeredNum = 0;
    if ([type isEqualToString:@"08"]||[type isEqualToString:@"11"]) {
        NSArray *completeBlanksAnswer = [[Commondata sharedInstance]completeBlanksAnswer];
        for (NSInteger i =0; i<[completeBlanksAnswer count]; i++) {
            if (![completeBlanksAnswer[i] isEqualToString:@""])
                answeredNum ++;
        }
    }
    
    if([self.showType isEqualToString:@"01"]){
        NSString *unanswerdStr = [NSString stringWithFormat:@"你还有%i题未答",questionSum-answeredNum];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:unanswerdStr];
        [str addAttribute:NSForegroundColorAttributeName value:NAVBAR_COLOR range:NSMakeRange(3,2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, str.length)];
        // [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
        uncompleteNumLabel.attributedText = str;
    }

}

- (void)nextQuestionAction {
  
    
    [lazyScrollView moveByPages:1 animated:YES];
    
    
    //[Animations moveLeft:qview andAnimationDuration:1.0 andWait:YES andLength:320];
    //UIScrollView * temp = scrollViewArray[0];
    
}





-(void) initTittleView{
    
    if ([self.showType isEqualToString:@"01"]) {
        tittleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,mainWidth,44)];
        tittleLabel = [[UILabel alloc] initWithFrame:CGRectMake(mainWidth/2-145, 0, 220, 40)];
        [tittleView addSubview: tittleLabel];
        //NSString *tittle  = [self getCourseName:self.course_id];
        tittleLabel.text = self.tittleName;
        tittleLabel.textAlignment = NSTextAlignmentCenter;
        tittleLabel.textColor = [UIColor whiteColor];
        tittleLabel.font = [UIFont systemFontOfSize:13];
        
        //练习时显示计时器
        counterLabel = [[MZTimerLabel alloc] initWithFrame:CGRectMake(mainWidth-95, 0, 150, 40)];
        // The font property of the label is used as the font for H,M,S and MS
        [counterLabel setFont:[UIFont systemFontOfSize:15]];
        [counterLabel setTextColor:[UIColor whiteColor]];
        counterLabel.timeFormat = @"HH:mm:ss";
        //[counterLabel updateApperance];
        
        [tittleView addSubview:counterLabel];
        self.navigationItem.titleView = tittleView;
    }else if ([self.showType isEqualToString:@"04"]){
        
        self.title = @"答题解析";
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15], NSFontAttributeName,nil]];
        self.title = self.tittleName;
    }
    
    
     
   }

-(void)initContentView{
    
    NSArray *question =[[Commondata sharedInstance] questionArray];
    
    questionSum   = [question count];
    questionIndex = 0;
    viewControllerArray = [[NSMutableArray alloc] initWithCapacity:questionSum];
    for (NSUInteger k = 0; k < questionSum; ++k) {
        [viewControllerArray addObject:[NSNull null]];
    }
    __weak __typeof(&*self)weakSelf = self;
    CGRect rect = CGRectMake(0, 5,  mainWidth, mainHeight-114);
    lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:rect];
    
    //lazyScrollView.backgroundColor = [UIColor redColor];
    [lazyScrollView setEnableCircularScroll:NO];
    lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    
    lazyScrollView.numberOfPages   = questionSum;
    lazyScrollView.controlDelegate = self;
    [self.view addSubview:lazyScrollView];
    
    [counterLabel start];
    
    
    NSString *type = [commonQuestionHead objectForKey:@"Type"];
    if([type isEqualToString:@"12"]){
        rect = CGRectMake(0, 5,  mainWidth, mainHeight-54);
        lazyScrollView.frame = rect;
    }else{
        
      //  [completeBanksTarView addSubview:checkAnswerButton];
    completeBanksTarView = [[UIView alloc]initWithFrame:CGRectMake(0, mainHeight-170, mainWidth, 60)];
    if([self.showType isEqualToString:@"01"]){
        uncompleteNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth/4-60, 25,120,10)];
    
        NSString *unanswerdStr = [NSString stringWithFormat:@"你还有%i题未答",questionSum];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:unanswerdStr];
        [str addAttribute:NSForegroundColorAttributeName value:NAVBAR_COLOR range:NSMakeRange(3,2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, str.length)];
    // [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
        uncompleteNumLabel.attributedText = str;
        [completeBanksTarView addSubview: uncompleteNumLabel];
    }else{
        if([self.showType isEqualToString:@"04"]){
            
            //添加底部工具栏 保持不变
         
            // completeBanksTarView.backgroundColor = [UIColor blueColor];
            checkAnswerButton = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2+mainWidth/8-12, 12, 50, 36)];
            [checkAnswerButton setBackgroundImage:[UIImage imageNamed:@"btn_ckda"] forState:UIControlStateNormal];
            [checkAnswerButton setBackgroundImage:[UIImage imageNamed:@"btn_ckda_click"] forState:UIControlStateSelected];
            [completeBanksTarView addSubview:checkAnswerButton];
            [checkAnswerButton addTarget:self action:@selector(hideExplainViewAction:) forControlEvents:UIControlEventTouchDown];
        checkAnswerButton.selected = true;
        }
    }
     [self.view addSubview:completeBanksTarView];
    
    
    audioPlayButton = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth*3/4-23+mainWidth/8, 12, 50, 36)];
    
    [audioPlayButton setBackgroundImage:[UIImage imageNamed:@"btn_tingt"] forState:UIControlStateNormal];
    
    [audioPlayButton addTarget:self
                        action:@selector(playAudioAction:) forControlEvents:UIControlEventTouchDown];
    
    [audioPlayButton setBackgroundImage:[UIImage imageNamed:@"btn_tingt_click"] forState:UIControlStateSelected];
    [completeBanksTarView addSubview:audioPlayButton];
    [[Commondata sharedInstance]setIsAdjustKeyboard:NO];
    }
    
}


-(void)initCompleteBlanksView{
    [[Commondata sharedInstance]setIsAdjustKeyboard:NO];
    
    //显示题目区域
    
    viewControllerArray = [[NSMutableArray alloc] initWithCapacity:questionSum];
    for (NSUInteger k = 0; k < questionSum; ++k) {
        [viewControllerArray addObject:[NSNull null]];
    }
    __weak __typeof(&*self)weakSelf = self;
    CGRect rect = CGRectMake(0, 0,  mainWidth, mainHeight-50);
    lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:rect];
    
   // lazyScrollView.backgroundColor = [UIColor redColor];
    [lazyScrollView setEnableCircularScroll:NO];
    lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    
    lazyScrollView.numberOfPages   = questionSum;
    lazyScrollView.controlDelegate = self;
    [self.view addSubview:lazyScrollView];
    
    [counterLabel start];
    
    //添加底部工具栏 保持不变
    completeBanksTarView = [[UIView alloc]initWithFrame:CGRectMake(0, mainHeight-170, mainWidth, 60)];
   // completeBanksTarView.backgroundColor = [UIColor blueColor];
    uncompleteNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 25,120,10)];
    if([self.showType isEqualToString:@"01"]){
    NSString *unanswerdStr = [NSString stringWithFormat:@"你还有%i题未答",questionSum];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:unanswerdStr];
    [str addAttribute:NSForegroundColorAttributeName value:NAVBAR_COLOR range:NSMakeRange(3,2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, str.length)];
   // [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
    uncompleteNumLabel.attributedText = str;
    [completeBanksTarView addSubview: uncompleteNumLabel];
    }
    [self.view addSubview:completeBanksTarView];
    
    /*
    UIButton *confirmAnswerButton = [[UIButton alloc]initWithFrame:CGRectMake(130, 20, 55, 20)];
    confirmAnswerButton.backgroundColor = NAVBAR_COLOR;
    [confirmAnswerButton setTitle:@"提交答案" forState:UIControlStateNormal];
    confirmAnswerButton.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [completeBanksTarView addSubview:confirmAnswerButton];
    */
    checkAnswerButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 12, 50, 36)];
    
    [checkAnswerButton setBackgroundImage:[UIImage imageNamed:@"btn_ckda"] forState:UIControlStateNormal];
    [checkAnswerButton addTarget:self
                          action:@selector(showExplainViewAction:) forControlEvents:UIControlEventTouchDown];
    
    
    [checkAnswerButton setBackgroundImage:[UIImage imageNamed:@"btn_ckda_click"] forState:UIControlStateSelected];
    [completeBanksTarView addSubview:checkAnswerButton];
    
    audioPlayButton = [[UIButton alloc]initWithFrame:CGRectMake(260, 12, 50, 36)];
    
    [audioPlayButton setBackgroundImage:[UIImage imageNamed:@"btn_tingt"] forState:UIControlStateNormal];
    
    [audioPlayButton addTarget:self
                          action:@selector(playAudioAction:) forControlEvents:UIControlEventTouchDown];
    
    [audioPlayButton setBackgroundImage:[UIImage imageNamed:@"btn_tingt_click"] forState:UIControlStateSelected];
    [completeBanksTarView addSubview:audioPlayButton];

}


-(void)showExplainViewAction:(UIButton*)button{
    
   button.selected = true;
    [checkAnswerButton removeTarget:self action:@selector(showExplainViewAction:) forControlEvents:UIControlEventTouchDown];
      [checkAnswerButton addTarget:self action:@selector(hideExplainViewAction:) forControlEvents:UIControlEventTouchDown];
    if (questionIndex > viewControllerArray.count || index < 0) return;
    QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex];
    [vc addExpalinView];
}

-(void)hideExplainViewAction:(UIButton*)button{
    
    button.selected = false;
    [checkAnswerButton removeTarget:self action:@selector(hideExplainViewAction:) forControlEvents:UIControlEventTouchDown];
   [checkAnswerButton addTarget:self action:@selector(showExplainViewAction:) forControlEvents:UIControlEventTouchDown];
    if (questionIndex > viewControllerArray.count || index < 0) return;
    QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex];
    [vc removeExpalinView];
}


-(void)playAudioAction:(UIButton*)button{
    
    button.selected = true;
    [button removeTarget:self action:@selector(playAudioAction:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self
                          action:@selector(stopAudioAction:) forControlEvents:UIControlEventTouchDown];
    if (questionIndex > viewControllerArray.count || index < 0) return;
    QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex];
    [vc showAudioAction];
    
    
}

-(void)stopAudioAction:(UIButton*)button{
    
    button.selected = false;
    [button removeTarget:self action:@selector(stopAudioAction:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self
               action:@selector(playAudioAction:) forControlEvents:UIControlEventTouchDown];
    if (questionIndex > viewControllerArray.count || index < 0) return;
    QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex];
    [vc pauseAdudioAction];
}


-(void)initUserfulExpressionsView{
    viewControllerArray = [[NSMutableArray alloc] initWithCapacity:questionSum];
    for (NSUInteger k = 0; k < questionSum; ++k) {
        [viewControllerArray addObject:[NSNull null]];
    }
    __weak __typeof(&*self)weakSelf = self;
    CGRect rect = CGRectMake(0, 0,  mainWidth, mainHeight);
    lazyScrollView = [[DMLazyScrollView alloc] initWithFrame:rect];
    
    //lazyScrollView.backgroundColor = [UIColor redColor];
    [lazyScrollView setEnableCircularScroll:NO];
    lazyScrollView.dataSource = ^(NSUInteger index) {
        return [weakSelf controllerAtIndex:index];
    };
    
    lazyScrollView.numberOfPages   = questionSum;
    lazyScrollView.controlDelegate = self;
    [self.view addSubview:lazyScrollView];
    
    [counterLabel start];

    
    
}

-(void)initListeningView{
    // NSArray *subQuestionArray = [ objectForKey:@"Sub_array"];
    // NSString *descripttion = [question objectForKey:@"Descripttion"];
    
    
    //currentY = 177;
    
    
    NSString * content = [commonQuestionHead objectForKey:@"Content"];
    
    content = [content stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    
   // content = [content stringByAppendingString:content];
    
    UILabel *contentLabel  = [[UILabel alloc] init];
    contentLabel.text          = content;
    contentLabel.numberOfLines = 0;// 需要把显示行数设置成无限制
    contentLabel.font          = [UIFont systemFontOfSize:17];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    CGSize size                = [self sizeWithString:contentLabel.text font:contentLabel.font cotentType:@"01"];
    contentLabel.frame         = CGRectMake(10, currentY, size.width, size.height);
    currentY = currentY +size.height +25;
    
    [contentScrollView addSubview:contentLabel];
}


-(void) initBottomView{
    tabView = [[UIView alloc]initWithFrame:CGRectMake(0, mainHeight-114, mainWidth, 50)];
    //UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.view addSubview:tabView];
    tabView.backgroundColor = [UIColor whiteColor];
    
    UIImageView* imgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 1)];
    imgLine.backgroundColor = [UIColor hexFloatColor:@"dedede"];
    [tabView addSubview:imgLine];
    
    
    CGFloat buttonWidth = mainWidth/5;
    
    lastQuestionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, 50)];
    
    [lastQuestionBtn setTitle:@"上一题" forState:UIControlStateNormal];
    [lastQuestionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lastQuestionBtn setImage:[UIImage imageNamed:@"grzx_ico_left_arrow"] forState:UIControlStateNormal];
    lastQuestionBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.lastQuestionBtn centerImageAndTitle];
    [lastQuestionBtn addTarget:self action:@selector(lastQuestionAction) forControlEvents:UIControlEventTouchDown];
    if (questionIndex==0) {
        lastQuestionBtn.enabled = NO;
    }
    
    [tabView addSubview:lastQuestionBtn];
    
  
    commitExcersiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth, 0, buttonWidth, 50)];
    
   // NSString *content = [NSString stringWithFormat:@"%i/%i",questionIndex+1,questionSum];
    [commitExcersiceBtn setTitle:@"交卷" forState:UIControlStateNormal];
    [commitExcersiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commitExcersiceBtn setImage:[UIImage imageNamed:@"language_ico_assignment"] forState:UIControlStateNormal];
    commitExcersiceBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.commitExcersiceBtn centerImageAndTitle];
    
    //[commitExcersiceBtn addTarget:self action:@selector(commitExcercise) forControlEvents:UIControlEventTouchUpInside];
    
    [commitExcersiceBtn addTarget:self action:@selector(commitExcersiceAction) forControlEvents:UIControlEventTouchDown];
    
    [tabView addSubview:commitExcersiceBtn];
    
    questionSum = [[[Commondata sharedInstance]questionArray]count];
    showExplainOrQuestNumBtn = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*2, 0, buttonWidth, 50)];
    NSString *content = [NSString stringWithFormat:@"%i/%i",questionIndex+1,questionSum];
    [showExplainOrQuestNumBtn setTitle:content forState:UIControlStateNormal];
    [showExplainOrQuestNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showExplainOrQuestNumBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [showExplainOrQuestNumBtn setImage:[UIImage imageNamed:@"language_ico_topic"] forState:UIControlStateNormal];
   // [showExplainOrQuestNumBtn setImage:[UIImage imageNamed:@"ico_collection_s"] forState:UIControlStateSelected];
    showExplainOrQuestNumBtn.titleLabel.font = [UIFont systemFontOfSize:11];
   // [showExplainOrQuestNumBtn addTarget:self action:@selector(showExplainOrQuestNumAction) forControlEvents:UIControlEventTouchUpInside];
    [self.showExplainOrQuestNumBtn centerImageAndTitle];
    
    [tabView addSubview:showExplainOrQuestNumBtn];
    
    farvoriteBtn = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*3, 0, buttonWidth, 50)];
     farvoriteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [farvoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSArray *sub_array = [commonQuestionHead objectForKey:@"Sub_array"];
    NSDictionary *question = sub_array[questionIndex];
    NSNumber *is_farvorite = [question objectForKey:@"IsFavourite"];
    
    if ([is_farvorite integerValue] ==0) {
        [farvoriteBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [farvoriteBtn setImage:[UIImage imageNamed:@"ico_collection"] forState:UIControlStateNormal];
        [farvoriteBtn addTarget:self action:@selector(addFarvoriteAction) forControlEvents:UIControlEventTouchDown];
    }else{
        [farvoriteBtn setTitle:@"取消" forState:UIControlStateNormal];
        //[farvoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [farvoriteBtn setImage:[UIImage imageNamed:@"ico_collection_s"] forState:UIControlStateNormal];
        //farvoriteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        
        [farvoriteBtn addTarget:self action:@selector(removeFarvoriteAction) forControlEvents:UIControlEventTouchDown];
    }
   
   
    [self.farvoriteBtn centerImageAndTitle];
    
    // farvoriteBtn.backgroundColor = [UIColor redColor];
    
    
    [tabView addSubview:farvoriteBtn];
    
    
    
    
    //CGFloat temp = self.view.frame.size.width-buttonWidth*4;
    // NSLog(@"width==%f",self.view.frame.size.width);
    nextQuestionBtn = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*4, 0, buttonWidth, 50)];
    
    [nextQuestionBtn setTitle:@"下一题" forState:UIControlStateNormal];
    [nextQuestionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextQuestionBtn setImage:[UIImage imageNamed:@"questiontypes_ico_arrow"] forState:UIControlStateNormal];
    nextQuestionBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [nextQuestionBtn addTarget:self action:@selector(nextQuestionAction) forControlEvents:UIControlEventTouchDown];
    if(questionSum==1){
        nextQuestionBtn.enabled = NO;
    }
    [self.nextQuestionBtn centerImageAndTitle];
    [tabView addSubview:nextQuestionBtn];
    
    if ([self.showType isEqualToString:@"01"]) {
    }else if ([self.showType isEqualToString:@"02"]){
        [farvoriteBtn setTitle:@"取消" forState:UIControlStateNormal];
        //[farvoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [farvoriteBtn setImage:[UIImage imageNamed:@"ico_collection_s"] forState:UIControlStateNormal];
        //farvoriteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [farvoriteBtn removeTarget: self action:@selector(addFarvoriteAction) forControlEvents:UIControlEventTouchDown];

        [farvoriteBtn addTarget:self action:@selector(removeFarvoriteAction) forControlEvents:UIControlEventTouchDown];
        [self.farvoriteBtn centerImageAndTitle];
        
        CGFloat buttonWidth = mainWidth/4;
        [commitExcersiceBtn removeFromSuperview];
        lastQuestionBtn.frame = CGRectMake(0, 0, buttonWidth, 50);
        showExplainOrQuestNumBtn.frame = CGRectMake(buttonWidth, 0, buttonWidth, 50);
        farvoriteBtn.frame = CGRectMake(buttonWidth*2, 0, buttonWidth, 50);
        nextQuestionBtn.frame = CGRectMake(buttonWidth*3, 0, buttonWidth, 50);
        
        
    }else if ([self.showType isEqualToString:@"03"]){
        //错题
        CGFloat buttonWidth = mainWidth/3;
        [farvoriteBtn removeFromSuperview];
        [commitExcersiceBtn removeFromSuperview];
//        [commitExcersiceBtn setTitle:@"题解" forState:UIControlStateNormal];
//        //[farvoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        //[farvoriteBtn setImage:[UIImage imageNamed:@"ico_ycct"] forState:UIControlStateNormal];
//        //farvoriteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//        [commitExcersiceBtn removeTarget:self action:@selector(commitExcersiceAction) forControlEvents:UIControlEventTouchDown];
//        [commitExcersiceBtn addTarget:self action:@selector(showExplainViewAction:) forControlEvents:UIControlEventTouchDown];
//        [self.commitExcersiceBtn centerImageAndTitle];
        
        
        lastQuestionBtn.frame = CGRectMake(0, 0, buttonWidth, 50);
        showExplainOrQuestNumBtn.frame = CGRectMake(buttonWidth, 0, buttonWidth, 50);
        nextQuestionBtn.frame = CGRectMake(buttonWidth*2, 0, buttonWidth, 50);
       // nextQuestionBtn.frame = CGRectMake(buttonWidth*3, 0, buttonWidth, 50);
    }

    else if ([self.showType isEqualToString:@"04"]){
        CGFloat buttonWidth = mainWidth/4;
        [commitExcersiceBtn removeFromSuperview];
        lastQuestionBtn.frame = CGRectMake(0, 0, buttonWidth, 50);
        showExplainOrQuestNumBtn.frame = CGRectMake(buttonWidth, 0, buttonWidth, 50);
        farvoriteBtn.frame = CGRectMake(buttonWidth*2, 0, buttonWidth, 50);
         nextQuestionBtn.frame = CGRectMake(buttonWidth*3, 0, buttonWidth, 50);
    }
    
    //暂时屏蔽题型5的提交
    
    NSString *type = [commonQuestionHead objectForKey:@"Type"];
    if ([type isEqualToString:@"12"]) {
        commitExcersiceBtn.enabled = NO;
    }
    
}

-(void)backToIndex

{
    //[self commitExcercise];
    //练习题保存进度
    
    __weak typeof (self) wSelf = self;
    NSString *type = [commonQuestionHead objectForKey:@"Type"];
    if([self.showType isEqualToString:@"01"]&&![type isEqualToString:@"12"]){
//        //判断答题是否完
            NSString *message = @"当前题目还没提交，是否确认退出";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确认",nil];
            alert.delegate =self;
            [alert show];

       // }
        backFlag = YES;
        
    }else{
       
        self.tabBarController.tabBar.hidden = NO;
        if ([self.showType isEqualToString:@"05"]) {
            
            
            [wSelf.navigationController popToRootViewControllerAnimated:YES];
        }else
            [wSelf.navigationController popViewControllerAnimated:YES];
    }
    
}



#pragma mark  -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex:%d",buttonIndex);
    if(buttonIndex==0){
        return;
    }else{
        //[self.navigationController popViewControllerAnimated:YES];

        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        
        //提交题目
        //self.tabBarController.tabBar.hidden = NO;
    }
}


#pragma lazyscrollView delegate
- (UIViewController *) controllerAtIndex:(NSInteger) index {
    if (index > viewControllerArray.count || index < 0) return nil;
    id res = [viewControllerArray objectAtIndex:index];
    if (res == [NSNull null]) {
        QuestionDetailVC *contr = [[QuestionDetailVC alloc] init];
        contr.questionIndex = index;
        contr.counterLabel = counterLabel;
       // contr.showType = self.showType;
        contr.detailType = self.showType;
        contr.lazyScrollView = contentScrollView;
        contr.originContentY = currentY;
        [viewControllerArray replaceObjectAtIndex:index withObject:contr];
        return contr;
    }
    return res;
}

- (void)lazyScrollView:(DMLazyScrollView *)pagingView currentPageChanged:(NSInteger)currentPageIndex{
    NSLog(@"currentIndex==%li",(long)currentPageIndex);
    questionIndex = currentPageIndex;
    if(currentPageIndex>=questionSum-1){
        self.nextQuestionBtn.enabled =FALSE;
    }else
        self.nextQuestionBtn.enabled = TRUE;
    if (currentPageIndex<=0) {
        self.lastQuestionBtn.enabled = FALSE;
    }else
        self.lastQuestionBtn.enabled = TRUE;
    
    //重置显示题解按钮
    NSString *content = [NSString stringWithFormat:@"%i/%i",currentPageIndex+1,questionSum];
    [showExplainOrQuestNumBtn setTitle:content forState:UIControlStateNormal];
    [showExplainOrQuestNumBtn centerImageAndTitle];
    
    
    if (questionIndex > viewControllerArray.count || index < 0) return;
    QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex];
    if (vc.textField) {
        [vc.textField becomeFirstResponder];
    }
    
    [checkAnswerButton removeTarget:self action:@selector(showExplainViewAction:) forControlEvents:UIControlEventTouchDown];
    [checkAnswerButton removeTarget:self action:@selector(hideExplainViewAction:) forControlEvents:UIControlEventTouchDown];
    //控制题解按钮
    if ([vc IsExplainViewShow]) {
        checkAnswerButton.selected = true;
        [checkAnswerButton removeTarget:self action:@selector(showExplainViewAction:) forControlEvents:UIControlEventTouchDown];
        [checkAnswerButton addTarget:self
                              action:@selector(hideExplainViewAction:) forControlEvents:UIControlEventTouchDown];
    }else{
        checkAnswerButton.selected = false;
        [checkAnswerButton removeTarget:self action:@selector(hideExplainViewAction:) forControlEvents:UIControlEventTouchDown];
        [checkAnswerButton addTarget:self
                              action:@selector(showExplainViewAction:) forControlEvents:UIControlEventTouchDown];
    }
    
    //控制题目显示
    
        //NSNumber *questId = [commonQuestionHead objectForKey:@"QuestId"];
    NSString *type = [commonQuestionHead objectForKey:@"Type"];
    NSInteger answeredNum = 0;
    if ([type isEqualToString:@"08"]||[type isEqualToString:@"11"]) {
        NSArray *completeBlanksAnswer = [[Commondata sharedInstance]completeBlanksAnswer];
        for (NSInteger i =0; i<[completeBlanksAnswer count]; i++) {
            if (![completeBlanksAnswer[i] isEqualToString:@""])
                answeredNum ++;
        }
    }else if([type isEqualToString:@"09"]||[type isEqualToString:@"10"]){
        
        NSMutableDictionary *useAnswerArray = [[Commondata sharedInstance]userAnswerArray];
        
        NSArray *keyArray  = [useAnswerArray allKeys];
        if ([keyArray count]>0) {
            NSDictionary *dic = [useAnswerArray objectForKey:keyArray[0]];
            
            NSArray *array = [dic objectForKey:@"ChildAnswers"];
            answeredNum = [array count];
        }else
            answeredNum = 0;
       
       // NSString *temp = [useAnswerArray objectForKey:@"ff"];
        
    }else{
        
        if(questionIndex>currentMaxIndex){
            playOrNot = true;
            currentMaxIndex = questionIndex;
        }else
            playOrNot = false;
        
        player = [[Commondata sharedInstance]player];
        if([player isPlaying])
            [player pause];
        
        if(playOrNot){
            [vc playUserfulExpressionAudio];
        }else{
            [vc pauseUserfulExpressionAudio];
            if(questionIndex+1<questionSum){
                QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex+1];
                [vc pauseUserfulExpressionAudio];
            }
            if(questionIndex>0){
                QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex-1];
                [vc pauseUserfulExpressionAudio];
            }
                
        }
        
        
    }
    if(![self.showType isEqualToString:@"04"]){
        if(audioPlayButton){
                audioPlayButton.selected = false;
                [audioPlayButton removeTarget:self action:@selector(stopAudioAction:) forControlEvents:UIControlEventTouchDown];
                [audioPlayButton addTarget:self
                           action:@selector(playAudioAction:) forControlEvents:UIControlEventTouchDown];
            
            [audioPlayButton sendActionsForControlEvents:UIControlEventTouchDown];
        }
   
    
    if([self.showType isEqualToString:@"01"]){
        NSString *unanswerdStr = [NSString stringWithFormat:@"你还有%i题未答",questionSum-answeredNum];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:unanswerdStr];
        [str addAttribute:NSForegroundColorAttributeName value:NAVBAR_COLOR range:NSMakeRange(3,2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, str.length)];
    // [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
        uncompleteNumLabel.attributedText = str;
        }
    }
    
    
    //控制收藏
    
    NSArray *sub_array = [commonQuestionHead objectForKey:@"Sub_array"];
    NSDictionary *question = sub_array[questionIndex];
    NSNumber *is_farvorite = [question objectForKey:@"IsFavourite"];
    
    if ([is_farvorite integerValue] ==0) {
        [farvoriteBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [farvoriteBtn setImage:[UIImage imageNamed:@"ico_collection"] forState:UIControlStateNormal];
        
        [farvoriteBtn removeTarget:self action:@selector(removeFarvoriteAction) forControlEvents:UIControlEventTouchDown];
        [farvoriteBtn addTarget:self action:@selector(addFarvoriteAction) forControlEvents:UIControlEventTouchDown];
    }else{
        [farvoriteBtn setTitle:@"取消" forState:UIControlStateNormal];
        //[farvoriteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [farvoriteBtn setImage:[UIImage imageNamed:@"ico_collection_s"] forState:UIControlStateNormal];
        //farvoriteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [farvoriteBtn removeTarget:self action:@selector(addFarvoriteAction) forControlEvents:UIControlEventTouchDown];
        [farvoriteBtn addTarget:self action:@selector(removeFarvoriteAction) forControlEvents:UIControlEventTouchDown];
    }
    
    
    [self.farvoriteBtn centerImageAndTitle];
    
    
    
}



-(void)addFarvoriteAction{
    [[XBToastManager ShardInstance] showprogress];
    NSString *token        = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    NSString *username     = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
   
   // NSNumber *qid          = [commonQuestionHead objectForKey:@"QuestId"];
    NSArray *sub_array = [commonQuestionHead objectForKey:@"Sub_array"];
    NSMutableDictionary *question = sub_array[questionIndex];
    NSNumber *qid          = [question objectForKey:@"Qid"];
    NSNumber *do_farvorite = [NSNumber numberWithInt:1];
    
    addFavoriteModel *api = [[addFavoriteModel alloc]initWithUsername:username token:token course_id:self.course_id id:qid do_favorite:do_farvorite];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"add farvoirte succeed");
        NSDictionary *root = nil;
        if([api isDataFromCache]){
            root = [api cacheJson];
        }
        else{
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        [[XBToastManager ShardInstance] hideprogress];
        NSLog(@"解析后的数据:%@", root);
        NSString *state = [root objectForKey:@"state"];
        NSString *info = [root objectForKey:@"info"];
        NSLog(@"info==%@",info);
        if([state intValue]==1){
            [[XBToastManager ShardInstance] showtoast:info];
            [farvoriteBtn setTitle:@"取消" forState:UIControlStateNormal];
            [farvoriteBtn setImage:[UIImage imageNamed:@"ico_collection_s"] forState:UIControlStateNormal];
            //farvoriteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
            [farvoriteBtn removeTarget:self action:@selector(addFarvoriteAction) forControlEvents:UIControlEventTouchDown];
            [farvoriteBtn addTarget:self action:@selector(removeFarvoriteAction) forControlEvents:UIControlEventTouchDown];
      //      [question setObject:do_farvorite forKey:@"IsFavourite"];
           
            [question objectForKey:@"IsFavourite"];
            [self.farvoriteBtn centerImageAndTitle];
            
           // [question replaceObjectAtIndex:questionIndex withObject:answer];
            // [question[questionIndex] setValue:do_farvorite forKey:@"is_favorite"];
            
        }else if([state intValue]==-2){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                                message: nil
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            

        }else{
//            [farvoriteBtn setTitle:@"取消" forState:UIControlStateNormal];
//            [farvoriteBtn setImage:[UIImage imageNamed:@"ico_collection_s"] forState:UIControlStateNormal];
//            //farvoriteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//            [farvoriteBtn removeTarget:self action:@selector(addFarvoriteAction) forControlEvents:UIControlEventTouchUpInside];
//            [farvoriteBtn addTarget:self action:@selector(removeFarvoriteAction) forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.farvoriteBtn centerImageAndTitle];
            [[XBToastManager ShardInstance] showtoast:info];
        }
    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"收藏失败，请稍后重试"];
        
    }];

}

-(void)removeFarvoriteAction{
    [[XBToastManager ShardInstance] showprogress];
    NSString *token        = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    NSString *username     = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
   // NSMutableArray *question =[[Commondata sharedInstance] questionArray];
    
    NSArray *sub_array = [commonQuestionHead objectForKey:@"Sub_array"];
    NSMutableDictionary *question = sub_array[questionIndex];
    NSNumber *qid          = [question objectForKey:@"Qid"];
    NSNumber *do_farvorite = [NSNumber numberWithInt:0];
    
    addFavoriteModel *api = [[addFavoriteModel alloc]initWithUsername:username token:token course_id:self.course_id id:qid do_favorite:do_farvorite];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"add farvoirte succeed");
        NSDictionary *root = nil;
        if([api isDataFromCache]){
            root = [api cacheJson];
        }
        else{
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        [[XBToastManager ShardInstance] hideprogress];
        NSLog(@"解析后的数据:%@", root);
        NSString *state = [root objectForKey:@"state"];
        NSString *info = [root objectForKey:@"info"];
        NSLog(@"info==%@",info);
        if([state intValue]==1){
            [[XBToastManager ShardInstance] showtoast:info];
            // NSNumber *do_farvorite = [question[questionIndex] objectForKey:@"is_favorite"];
            [farvoriteBtn setTitle:@"增加" forState:UIControlStateNormal];
            [farvoriteBtn setImage:[UIImage imageNamed:@"ico_collection"] forState:UIControlStateNormal];
            //farvoriteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
            [farvoriteBtn removeTarget:self action:@selector(removeFarvoriteAction) forControlEvents:UIControlEventTouchDown];
            [farvoriteBtn addTarget:self action:@selector(addFarvoriteAction) forControlEvents:UIControlEventTouchDown];
    //        [question setObject:do_farvorite forKey:@"IsFavourite"];
            [self.farvoriteBtn centerImageAndTitle];
        
            
        }else if([state intValue]==0){
            [[XBToastManager ShardInstance] showtoast:info];
        }

        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                            message: nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }

    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"移除收藏失败，请稍后重试"];
        
    }];

}



    
-(void)commitExcersiceAction{
    
    [counterLabel pause];
    
     NSString *type = [commonQuestionHead objectForKey:@"Type"];
    
    if ([type isEqualToString:@"08"]||[type isEqualToString:@"11"]) {
        [self backgroundTap];
        
        [self saveCompleteBlanksOrSpotDitactionAction];

    }
    NSMutableDictionary *userAnswerArray = [[Commondata sharedInstance]userAnswerArray];
    NSMutableArray *answerArray = [[NSMutableArray alloc]initWithCapacity:4];
    if([userAnswerArray count]>0){
    for (NSString *key in userAnswerArray ){
        NSArray *array = [[NSArray alloc]initWithObjects:userAnswerArray[key], nil];
        [answerArray addObjectsFromArray:array];
    }
    
   
    NSString *token        = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    NSString *username     = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
 
    [[XBToastManager ShardInstance] showprogress];
    commitExcerciseModel *api = [[commitExcerciseModel alloc]initWithUsername:username token:token course_id:@"224" answers:answerArray];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"add farvoirte succeed");
        NSDictionary *root = nil;
        if([api isDataFromCache]){
            root = [api cacheJson];
        }
        else{
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        [[XBToastManager ShardInstance] hideprogress];
        NSLog(@"解析后的数据:%@", root);
        NSString *state = [root objectForKey:@"state"];
        NSString *info = [root objectForKey:@"info"];
        NSLog(@"info==%@",info);
        if([state intValue]==1){
            NSDictionary *result = [root objectForKey:@"result"];
            [[XBToastManager ShardInstance] showtoast:info];
            QuestionResultVC *vc = [[QuestionResultVC alloc]init];
            NSInteger allQuestNum = [[result objectForKey:@"TotalQuestNumber"] integerValue];
            NSInteger hasDoNum = [[result objectForKey:@"HasDoNum"] integerValue];
            NSInteger donotNumber = [[result objectForKey:@"DonotNumber"] integerValue];
             NSInteger rightNumber = [[result objectForKey:@"RightNumber"] integerValue];
             NSInteger wrongNumber = [[result objectForKey:@"WrongNumber"] integerValue];
              NSInteger correctRate = [[result objectForKey:@"CorrectRate"] integerValue];
            vc.allQuestNum = allQuestNum;
            vc.completeQuestNum = hasDoNum;
            vc.wrongQuestNum = wrongNumber;
            vc.rightQuestNum = rightNumber;
            vc.donotNumber = donotNumber;
            vc.counterTime = counterLabel.text;
            vc.correctRate = correctRate;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                            message: nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }

    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"提交失败，请稍后重试"];
        
    }];
    }else
        [[XBToastManager ShardInstance] showtoast:@"抱歉，您还没有答题"];
}


//保存填空题等题型的答案
-(void)saveCompleteBlanksOrSpotDitactionAction{
    NSNumber *questId = [commonQuestionHead objectForKey:@"QuestId"];
    NSString *type = [commonQuestionHead objectForKey:@"Type"];
    NSArray *completeBlanksAnswer = [[Commondata sharedInstance]completeBlanksAnswer];
    
    NSArray *subArray = [commonQuestionHead objectForKey:@"Sub_array"];
    NSMutableArray *childArrays = [[NSMutableArray alloc]initWithCapacity:1];
    
    
    
    //NSString *userAnswer =@"";
    for (NSInteger i =0; i<[completeBlanksAnswer count]&&![completeBlanksAnswer[i] isEqualToString:@""]; i++) {
//       // NSDictionary *answerDic = [[NSDictionary alloc]init];
//       [answerDic ]
//        
//        
//        [answerDic add:completeBlanksAnswer[i] forKey:@"UserAnswer"];
//        [answerDic setValue:[subArray[i] objectForKey:@"Qid"] forKey:@"ChildQuestId"];
        
        NSDictionary *answerDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              completeBlanksAnswer[i], @"UserAnswer",
                              [subArray[i] objectForKey:@"Qid"], @"ChildQuestId",
                              nil];
        
        [childArrays addObject:answerDic];
    }
    
//    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:userAnswer,@"UserAnswer",
//                         questId,@"ChildQuestId" ,nil];
//    [childArrays addObject:dic];
    
    NSDictionary *answerDic  = [[NSDictionary alloc]initWithObjectsAndKeys:questId,@"QuestId",
                                type,@"QuestType",childArrays,@"ChildAnswers",nil];
    
    NSMutableDictionary *useAnswerArray = [[Commondata sharedInstance]userAnswerArray];
    [useAnswerArray removeAllObjects];
    [useAnswerArray setObject:answerDic forKey:questId];
}

#pragma mark - Navigation

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font cotentType:(NSString *)cotentType
{
    //题干
    if([cotentType isEqualToString:@"01"]){
        CGRect rect = [string boundingRectWithSize:CGSizeMake(mainWidth-25, 400)//限制最大的宽度和高度
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                        attributes:@{NSFontAttributeName: font}//传人的字体字典
                                           context:nil];
        
        return rect.size;}
    else{//问题选项
        CGRect rect = [string boundingRectWithSize:CGSizeMake(mainWidth-40, 400)//限制最大的宽度和高度
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                        attributes:@{NSFontAttributeName: font}//传人的字体字典
                                           context:nil];
        return rect.size;
    }
}

-(void)backgroundTap
{
    NSLog(@"tap iiii");
    
    if (questionIndex > viewControllerArray.count || index < 0) return;
    QuestionDetailVC *vc = [viewControllerArray objectAtIndex:questionIndex];
    [vc dismissKeybordAction];
}

#pragma mark  -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(!backFlag)
        [[Commondata sharedInstance] backToLoginVC:self];
    else{
        backFlag = NO;
        
    }
}

@end
