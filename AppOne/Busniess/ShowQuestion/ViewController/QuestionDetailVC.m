//
//  QuestionDetailVC.m
//  AppOne
//
//  Created by lile on 15/9/15.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "QuestionDetailVC.h"


@interface QuestionDetailVC ()<MBProgressHUDDelegate> {
    UIScrollView   * scrollView;
    CGFloat currentY;
    CGFloat allLength;
    
    AVAudioPlayer * player;
    AVAudioSession *session;
    NSMutableData * receiveData;
    
    AVAudioRecorder *recorder;
    NSTimer *timer;

    
    UIImageView *questionAudioImage;
    UIImageView *answerAudioImage;
    UIButton *recordAudioBtn;
    UILabel *questionContenLabel;
    UIButton *playSavedAudioBtn;
    MBProgressHUD *HUD;
    NSString *audioFileName;
    NSString *savedAudioPath;
    UIButton *mircoPhoneBtn;
    UIButton *submmitBtn;
    UIButton *playAudioBtn;
    UIButton *saveAudioBtn;
    NSMutableDictionary *qcheckArrayDic;
    NSMutableDictionary *selectResultDic;
    NSArray *questionArray;
    NSDictionary * question;
    UITextField *currentTextField;
    NSString *tempAudioPath;
 
    NSDictionary *commonQuestionHead;
    float width;
    float height;
    float offset;
    CGFloat contentOffset;
    
    NSString *deviceString;
    UIView *explainView;
    BOOL audioIsPlaying;
    NSString * type;

    
}

/** 录音工具 */
@property (nonatomic, strong) LVRecordTool *recordTool;

/** 录音时的图片 */
@property (strong, nonatomic)  UIImageView *imageView;

/** 录音按钮 */
@property (weak, nonatomic)  UIButton *recordBtn;

/** 播放按钮 */
@property (weak, nonatomic)  UIButton *playBtn;
@end

@implementation QuestionDetailVC
@synthesize textField;


- (void)viewDidLoad {
    [super viewDidLoad];
    currentY = 0;
    selectResultDic = [[Commondata sharedInstance]selectResultDic];
    questionArray = [[Commondata sharedInstance]questionArray];
    commonQuestionHead = [[Commondata sharedInstance]commonQuestionHead];
   // question = questionArray[self.questionIndex];
    type = [commonQuestionHead objectForKey:@"Type"];
    if ([type isEqualToString:@"08"]) {
         questionArray = [[Commondata sharedInstance]subQuestionArray];
        [self initCompleteBlanksContentView];
       
    }else if ([type isEqualToString:@"09"]){
        [self initListenningChoiceContentView];
    }else if ([type isEqualToString:@"10"]){
        [self initTrueOrFalseContentView];
    }else if ([type isEqualToString:@"11"]){
        questionArray = [[Commondata sharedInstance]subQuestionArray];
        [self initCompleteBlanksContentView];

    }else if ([type isEqualToString:@"12"]){
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *questId = [questionArray[_questionIndex] objectForKey:@"Qid"];
        NSString *savedAudioName =[NSString stringWithFormat:@"Record%@.caf",questId];
        savedAudioPath=[path  stringByAppendingPathComponent:savedAudioName];
        //[session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
//       session = [AVAudioSession sharedInstance];
//        NSError *sessionError;
//        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
//        
//        if(session == nil)
//            NSLog(@"Error creating session: %@", [sessionError description]);
//        else
//            [session setActive:YES error:nil];

        NSLog(@"+++++filePath = %@",savedAudioPath);

        self.recordTool = [LVRecordTool sharedRecordTool];
        self.recordTool.delegate = self;
        //self.recordTool.player.delegate = self;
        //self.recordTool.recorder.url = @"url";
        [self initUsefulExpressionsContentView];
       
    }
    
    
    NSString *questId = [questionArray[_questionIndex] objectForKey:@"Qid"];
    NSString *attachmentsType = [questionArray[_questionIndex] objectForKey:@"AttachmentsType"];
    //NSString *demoString = [answer objectForKey:@"Id"];
    audioFileName = [NSString stringWithFormat:@"%@",@"224"];
    audioFileName = [audioFileName stringByAppendingFormat:@"%@",questId];
    if ([attachmentsType integerValue]==2) {
        audioFileName = [audioFileName stringByAppendingString:@".mp3"];
    }else if ([attachmentsType integerValue]==3) {
        audioFileName = [audioFileName stringByAppendingString:@".mp4"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    audioIsPlaying =false;
    NSLog(@"laz contentsize @%f",self.lazyScrollView.contentSize.height);
  //  self.lazyScrollView.contentSize = CGSizeMake(mainWidth,  self.originContentY+currentY);
    //if(_questionIndex>0&&textField)
      //  [textField becomeFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated{
   // [self saveUserAnswer];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    currentTextField = nil;
}


-(void)questionAudioPressed{
   // [playAudioBtn sendActionsForControlEvents:UIControlEventTouchDown];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)initListenningChoiceContentView{
    NSArray *subQuestionArray = [[Commondata sharedInstance]questionArray];
    currentY = 10;
    //初始化题目
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        NSDictionary * subQuestion = subQuestionArray[_questionIndex];
        NSArray *answer_array = [subQuestion objectForKey:@"Answer_array"];
        NSNumber *questID = [subQuestion objectForKey:@"Parent_id"];
        NSNumber *childQid = [subQuestion objectForKey:@"Qid"];
        NSString  *content = [NSString stringWithFormat:@"%i. ",_questionIndex+1];
        content = [content stringByAppendingString:[subQuestion objectForKey:@"Content"]];
    
    
        //content = [subQuestion objectForKey:@"Content"];
        UILabel *contentLabel  = [[UILabel alloc] init];
        contentLabel.text          = content;
        contentLabel.numberOfLines = 0;// 需要把显示行数设置成无限制
        contentLabel.font          = [UIFont systemFontOfSize:17];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        CGSize size                = [self sizeWithString:contentLabel.text font:contentLabel.font cotentType:@"01"];
        contentLabel.frame         = CGRectMake(10, currentY, size.width, size.height);
        currentY = currentY +size.height +25;
        [scrollView addSubview:contentLabel];
        
        
        for (NSInteger j =0; j<[answer_array count]; j++) {
            
            NSDictionary * answer_option = answer_array[j];
            UIView * optionView = [[UIView alloc]init];
            
            NSString *optionContent = [answer_option objectForKey:@"Content"];
            NSNumber *qid = [answer_option objectForKey:@"ParentQid"];
            QCheckBox *qcheck = [[QCheckBox alloc] initWithDelegate:self];
            qcheck.tag = qid.integerValue;
           // NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:qcheck,qcheck.tag,nil];
            //[qcheckArrayDic addEntriesFromDictionary:dic];
            [qcheck.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
            qcheck.titleLabel.numberOfLines = 0;
            qcheck.titleLabel.textAlignment = NSTextAlignmentLeft;
            
            CGSize qboxsize =  [self sizeWithString:optionContent font:qcheck.titleLabel.font cotentType:@"02"];
            
            qcheck.frame = CGRectMake(10, 10, qboxsize.width+60, qboxsize.height);
            //qcheck.titleLabel.frame =CGRectMake(0, 0, qboxsize.width-40, qboxsize.height);
      
            [qcheck setTitle:optionContent forState:UIControlStateNormal];
            [qcheck setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
            //   [qcheck setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
           // [qcheck setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            
            NSString *Id = [answer_option objectForKey:@"Id"];
            [qcheck setUserInfo:Id];
            NSString *imageName = @"choice_ico_a";
            if ([Id isEqualToString:@"B"]) {
                imageName = @"choice_ico_b";
            }else if ([Id isEqualToString:@"C"]){
                imageName = @"choice_ico_c";
            }else if ([Id isEqualToString:@"D"]){
                imageName = @"choice_ico_d";
            }
            [qcheck setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
            imageName = [imageName stringByAppendingString:@"1"];
            [qcheck setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            optionView.frame = CGRectMake(0, currentY, mainWidth, qboxsize.height+20);
           // optionView.tag = (i+1)*10+j+1;
            [optionView addSubview:qcheck];
            [scrollView addSubview:optionView];
            
            currentY = currentY +qboxsize.height+40;
        
            //题解
            if ([self.detailType isEqualToString:@"04"]) {
                NSString *isRight = [answer_option objectForKey:@"Is_right"];
                //QCheckBox *checkBox = [selectResultDic objectForKey:qid];
                
                NSMutableDictionary *useAnswerArray = [[Commondata sharedInstance]userAnswerArray];
                //[useAnswerArray setObject:answerDic forKey:QuestId];
                NSDictionary *answerDic = [useAnswerArray objectForKey:questID];
                NSArray  *childArrays = [answerDic objectForKey:@"ChildAnswers"];
                NSString * answer = nil;
                if(childArrays){
                    for(NSInteger k=0;k<[childArrays count];k++){
                        NSDictionary *dic = childArrays[k];
                        NSNumber *childQuestId = [dic objectForKey:@"ChildQuestId"];
                    if (childQuestId.integerValue ==childQid.integerValue ) {
                        answer = [dic objectForKey:@"UserAnswer"];
                        break;
                    }
                    
                }
            }
               
                if ([answer isEqualToString:qcheck.userInfo]) {
                    qcheck.superview.backgroundColor = [UIColor hexFloatColor:@"d0d0d0"];
                    if ([isRight isEqualToString:@"0"]) {
                        [qcheck setImage:[UIImage imageNamed:@"wrong_ico"] forState:UIControlStateNormal];
                    }
                    
                }
                if([isRight isEqualToString:@"1"])
                    [qcheck setImage:[UIImage imageNamed:@"right_ico"] forState:UIControlStateNormal];
                
                qcheck.userInteractionEnabled = NO;
            }

        }
    //currentY = currentY;
    [self.view  addSubview:scrollView];
    
    if ([self.detailType isEqualToString:@"04"]) {
        [self addExpalinView];
    }
}


-(void)initTrueOrFalseContentView{
    
    NSArray *subQuestionArray = [[Commondata sharedInstance]questionArray];
    
    //初始化题目
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:scrollView];
    NSDictionary * subQuestion = subQuestionArray[_questionIndex];
    NSArray *answer_array = [subQuestion objectForKey:@"Answer_array"];
    NSNumber *questID = [subQuestion objectForKey:@"Parent_id"];
    NSNumber *childQid = [subQuestion objectForKey:@"Qid"];
    NSString  *content = [NSString stringWithFormat:@"%i. ",_questionIndex+1];
    content = [content stringByAppendingString:[subQuestion objectForKey:@"Content"]];
    //content = [subQuestion objectForKey:@"Content"];
    UILabel *contentLabel  = [[UILabel alloc] init];
    contentLabel.text          = content;
    contentLabel.numberOfLines = 0;// 需要把显示行数设置成无限制
    contentLabel.font          = [UIFont systemFontOfSize:17];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    CGSize size                = [self sizeWithString:contentLabel.text font:contentLabel.font cotentType:@"01"];
    contentLabel.frame         = CGRectMake(10, currentY, size.width, size.height);
    currentY = currentY +size.height +25;
    [scrollView addSubview:contentLabel];
    
    
    for (NSInteger j =0; j<[answer_array count]; j++) {
        
        NSDictionary * answer_option = answer_array[j];
        UIView * optionView = [[UIView alloc]init];
        
        NSString *optionContent = [answer_option objectForKey:@"Id"];
        NSNumber *qid = [answer_option objectForKey:@"ParentQid"];
        QCheckBox *qcheck = [[QCheckBox alloc] initWithDelegate:self];
        qcheck.tag = qid.integerValue;
        // NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:qcheck,qcheck.tag,nil];
        //[qcheckArrayDic addEntriesFromDictionary:dic];
        [qcheck.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        qcheck.titleLabel.numberOfLines = 0;
        qcheck.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        CGSize qboxsize =  [self sizeWithString:optionContent font:qcheck.titleLabel.font cotentType:@"02"];
        
        qcheck.frame = CGRectMake(10, 10, qboxsize.width+60, qboxsize.height);
        //qcheck.titleLabel.frame =CGRectMake(0, 0, qboxsize.width-40, qboxsize.height);
        
        [qcheck setTitle:optionContent forState:UIControlStateNormal];
        [qcheck setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //   [qcheck setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
        // [qcheck setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
        NSString *Id = [answer_option objectForKey:@"Id"];
        [qcheck setUserInfo:Id];
        NSString *imageName = @"choice_ico_a";
        if ([Id isEqualToString:@"错误"]) {
            imageName = @"choice_ico_b";
        }
        [qcheck setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
        imageName = [imageName stringByAppendingString:@"1"];
        [qcheck setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        optionView.frame = CGRectMake(0, currentY, mainWidth, qboxsize.height+20);
        // optionView.tag = (i+1)*10+j+1;
        [optionView addSubview:qcheck];
        [scrollView addSubview:optionView];
        
        currentY = currentY +qboxsize.height+40;
        
        if ([self.detailType isEqualToString:@"04"]) {
            
            NSString *isRight = [answer_option objectForKey:@"Is_right"];
            //QCheckBox *checkBox = [selectResultDic objectForKey:qid];
            
            NSMutableDictionary *useAnswerArray = [[Commondata sharedInstance]userAnswerArray];
            //[useAnswerArray setObject:answerDic forKey:QuestId];
            NSDictionary *answerDic = [useAnswerArray objectForKey:questID];
            
            NSArray  *childArrays = [answerDic objectForKey:@"ChildAnswers"];
            NSString * answer = nil;
            if(childArrays){
                for(NSInteger k=0;k<[childArrays count];k++){
                    NSDictionary *dic = childArrays[k];
                    NSNumber *childQuestId = [dic objectForKey:@"ChildQuestId"];
                    if (childQuestId.integerValue ==childQid.integerValue ) {
                        answer = [dic objectForKey:@"UserAnswer"];
                        break;
                    }
                    
                }
            }
            
            if ([answer isEqualToString:qcheck.userInfo]) {
                qcheck.superview.backgroundColor = [UIColor hexFloatColor:@"d0d0d0"];
                if ([isRight isEqualToString:@"0"]) {
                    [qcheck setImage:[UIImage imageNamed:@"wrong_ico"] forState:UIControlStateNormal];
                }
                
            }
            if([isRight isEqualToString:@"1"])
                [qcheck setImage:[UIImage imageNamed:@"right_ico"] forState:UIControlStateNormal];
            
            qcheck.userInteractionEnabled = NO;

        }
    
    }
    
    scrollView.contentSize = CGSizeMake(mainWidth,  self.originContentY+currentY);
    if ([self.detailType isEqualToString:@"04"]) {
        [self addExpalinView];
    }
}

-(void)initSpotDictationContentView{
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 25, 20)];
    NSString *tittleNum = [NSString stringWithFormat:@"%i.",self.questionIndex+1];
    label.text = tittleNum;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    textField = [[AnswerTextField alloc]initWithFrame:CGRectMake(35, 10, mainWidth-65, 20)];
    textField.tag = self.questionIndex;
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeAlphabet;
    textField.clearButtonMode = YES;
    [self.view addSubview:textField];
    
    currentY = currentY+50;
    
    //[textField becomeFirstResponder];
    
    submmitBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2-50, currentY, 100, 40)];
    [submmitBtn setTitle:@"提交题目" forState:UIControlStateNormal];
    [submmitBtn setBackgroundColor:NAVBAR_COLOR];
    //[mircoPhoneBtn setBackgroundImage:[UIImage imageNamed:@"choice_btn_listening"] forState:UIControlStateNormal];
    [submmitBtn addTarget:self action:@selector(submmitBtnCompleteBlanksAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submmitBtn];
    
    //self.lazyScrollView.contentSize = CGSizeMake(mainWidth, currentY+60);
    
    self.lazyScrollView.contentSize = CGSizeMake(mainWidth,  self.originContentY+currentY+60);
}
-(void)initCompleteBlanksContentView{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeybordAction)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    currentY =0;
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    NSDictionary *subQuestion = questionArray[self.questionIndex];
    
    NSString *content = [subQuestion objectForKey:@"Content"];
    
    
    
    // content = [content stringByAppendingString:content];
    

    
    /*
    
      NSString *subStr = [NSString stringWithFormat:@"__%i__",_questionIndex+1];
     content = [content stringByReplacingOccurrencesOfString:subStr withString:@" Afternooiiiiiii"];
     NSArray *array = [content componentsSeparatedByString:@"<br/>"];
         NSInteger lineIndex =0;
    NSRange subRange;
    for (NSInteger i=0; i<[array count]; i++) {
      subRange= [array[i] rangeOfString:@"Afternooiiiiiii" ];
        if (subRange.length==15) {
            lineIndex = i;
            break;
        }
    }
    CGSize singleSize                = [self sizeWithString:@"a" font:[UIFont systemFontOfSize:17] cotentType:@"01"];
    contentLabel.text = content;
    
    //contentLabel.text = [content stringByReplacingOccurrencesOfString:@"Afternooiiiiiii" withString:@"                     "];
  
    UITextField *temp = [[UITextField alloc]initWithFrame:CGRectMake(10+subRange.location*singleSize.width,singleSize.height*lineIndex+3, singleSize.width*9, singleSize.height)];
        temp.borderStyle =UITextBorderStyleLine;
        [scrollView addSubview:temp];
    
     content = [content stringByReplacingOccurrencesOfString:@"Afternooiiiiiii" withString:@"                  "];
    
    
    */
    content = [content stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    UILabel *contentLabel  = [[UILabel alloc] init];
    contentLabel.text          = content;
    contentLabel.numberOfLines = 0;// 需要把显示行数设置成无限制
    contentLabel.font          = [UIFont systemFontOfSize:20];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    
    contentLabel.text = content;
    

    CGSize size                = [self sizeWithString:contentLabel.text font:contentLabel.font cotentType:@"01"];
    contentLabel.frame         = CGRectMake(10, 0, size.width, size.height);
   // contentLabel.text = content;
    
    [scrollView addSubview:contentLabel];
    
    
    UILabel *lineNum =[[UILabel alloc]initWithFrame:CGRectMake(10, size.height +45, 25, 20)];
    lineNum.text = [NSString stringWithFormat:@"%i.",self.questionIndex+1];
    [self.view addSubview:lineNum];
    textField = [[AnswerTextField alloc]initWithFrame:CGRectMake(35, size.height +45, mainWidth-65, 20)];
    textField.tag = self.questionIndex;
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeAlphabet;
    textField.clearButtonMode = YES;
    [scrollView addSubview:textField];
    
     currentY = size.height +75;
    
    [self.view addSubview:scrollView];
    
    if ([self.detailType isEqualToString:@"04"]) {
        textField.userInteractionEnabled = false;
        NSMutableArray *completeBlanksAnswer = [[Commondata sharedInstance]completeBlanksAnswer];
        textField.text =completeBlanksAnswer[_questionIndex];
        [self addExpalinView];
    }
}
-(void)initUsefulExpressionsContentView{
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:scrollView];
    
    UILabel *demoLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 20)];
    demoLabel.font = [UIFont systemFontOfSize:17];
    demoLabel.text = @"说出你的句子";
    demoLabel.textColor = [UIColor hexFloatColor:@"cacaca"];
    //demoLabel.textAlignment = NSTextAlignmentRight;
    [scrollView addSubview: demoLabel];
    
    
    UILabel *questionNum =[[UILabel alloc]initWithFrame:CGRectMake(15, 50, 40, 20)];
    questionNum.font = [UIFont systemFontOfSize:17];
    questionNum.text = [NSString stringWithFormat:@"题%i.",_questionIndex+1];
    questionNum.textColor = [UIColor blackColor];

    [scrollView addSubview:questionNum];
    
    questionAudioImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 53, mainWidth-70, 14)];
    
    [questionAudioImage setImage:[UIImage imageNamed:@"question_voice1"]];
    [scrollView addSubview:questionAudioImage];
    
    
    UILabel *answerNum =[[UILabel alloc]initWithFrame:CGRectMake(15, 120, 40, 20)];
    answerNum.font = [UIFont systemFontOfSize:17];
    answerNum.text = [NSString stringWithFormat:@"练%i.",_questionIndex+1];
    answerNum.textColor = [UIColor blackColor];
    
    [scrollView addSubview:answerNum];
    
    answerAudioImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 123, mainWidth-70, 14)];
    
   answerAudioImage.image = [UIImage imageNamed:@"saved_voice1"];
    
    [scrollView addSubview:answerAudioImage];
    
    
    recordAudioBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/10-27, self.view.frame.size.height-200, 54, 54)];
    [recordAudioBtn setBackgroundImage:[UIImage imageNamed:@"btn_luyin"] forState:UIControlStateNormal];
    [recordAudioBtn setBackgroundImage:[UIImage imageNamed:@"btn_luyin_click"] forState:UIControlStateSelected];
 
    [scrollView addSubview:recordAudioBtn];
    
    [recordAudioBtn addTarget:self action:@selector(recordBtnDidTouchDown:) forControlEvents:UIControlEventTouchDown];
    [recordAudioBtn addTarget:self action:@selector(recordBtnDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [recordAudioBtn addTarget:self action:@selector(recordBtnDidTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];

    
    UILabel *recordLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth/10-20, self.view.frame.size.height-200+54+5, 40, 20)];
    recordLabel.textColor = [UIColor hexFloatColor:@"cacaca"];
    recordLabel.text = @"录音";
    recordLabel.textAlignment = NSTextAlignmentCenter;
    recordLabel.font = [UIFont systemFontOfSize:17];
    [scrollView addSubview:recordLabel];
    
    
    playSavedAudioBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth*3/10-27, self.view.frame.size.height-200, 54, 54)];
    [playSavedAudioBtn setBackgroundImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    [playSavedAudioBtn setBackgroundImage:[UIImage imageNamed:@"btn_play_click"] forState:UIControlStateSelected];
    [playSavedAudioBtn addTarget:self action:@selector(playRecordingFile) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:playSavedAudioBtn];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断文件是否存在
    if(![fileManager fileExistsAtPath:savedAudioPath]){ //如果不存
        playSavedAudioBtn.enabled = false;
         answerAudioImage.image = [UIImage imageNamed:@"voice_no"];
        
    }

    
    UILabel *palySavedLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth*3/10-20, self.view.frame.size.height-200+54+5, 40, 20)];
    palySavedLabel.textColor = [UIColor hexFloatColor:@"cacaca"];
    palySavedLabel.text = @"播放";
    palySavedLabel.textAlignment = NSTextAlignmentCenter;
    palySavedLabel.font = [UIFont systemFontOfSize:17];
    [scrollView addSubview:palySavedLabel];
    
    saveAudioBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/2-27, self.view.frame.size.height-200, 54, 54)];
    [saveAudioBtn setBackgroundImage:[UIImage imageNamed:@"btn_cunchu"] forState:UIControlStateNormal];
    [saveAudioBtn setBackgroundImage:[UIImage imageNamed:@"btn_cunchu_click"] forState:UIControlStateSelected];
    [saveAudioBtn addTarget:self action:@selector(saveAudioAction) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:saveAudioBtn];
    saveAudioBtn.enabled = false;
    
    UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth/2-20, self.view.frame.size.height-200+54+5, 40, 20)];
    saveLabel.textColor = [UIColor hexFloatColor:@"cacaca"];
    saveLabel.text = @"存储";
    saveLabel.textAlignment = NSTextAlignmentCenter;
    saveLabel.font = [UIFont systemFontOfSize:17];
    [scrollView addSubview:saveLabel];
    
    UIButton *wordShowBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth*7/10-27, self.view.frame.size.height-200, 54, 54)];
    [wordShowBtn setBackgroundImage:[UIImage imageNamed:@"btn_ziti"] forState:UIControlStateNormal];
    [wordShowBtn setBackgroundImage:[UIImage imageNamed:@"btn_ziti_click"] forState:UIControlStateSelected];
    [wordShowBtn addTarget:self action:@selector(showWordAction:) forControlEvents:UIControlEventTouchDown];
    [scrollView addSubview:wordShowBtn];
    
    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth*7/10-20, self.view.frame.size.height-200+54+5, 40, 20)];
    wordLabel.textColor = [UIColor hexFloatColor:@"cacaca"];
    wordLabel.text = @"字题";
    wordLabel.textAlignment = NSTextAlignmentCenter;
    wordLabel.font = [UIFont systemFontOfSize:17];
    [scrollView addSubview:wordLabel];
    
    playAudioBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth*9/10-27, self.view.frame.size.height-200, 54, 54)];
    [playAudioBtn setBackgroundImage:[UIImage imageNamed:@"btn_tingti"] forState:UIControlStateNormal];
    [playAudioBtn addTarget:self action:@selector(playQuestionAudio) forControlEvents:UIControlEventTouchDown];
    [playAudioBtn setBackgroundImage:[UIImage imageNamed:@"btn_tingti_click"] forState:UIControlStateSelected];
    [scrollView addSubview:playAudioBtn];
    
    UILabel *playLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth*9/10-20, self.view.frame.size.height-200+54+5, 40, 20)];
    playLabel.textColor = [UIColor hexFloatColor:@"cacaca"];
    playLabel.text = @"听题";
    playLabel.textAlignment = NSTextAlignmentCenter;
    playLabel.font = [UIFont systemFontOfSize:17];
    [scrollView addSubview:playLabel];
    
    
    scrollView.contentSize = CGSizeMake(mainWidth, 380+114+45*heightRation);
    
    

}

-(void)saveAudioAction{
    NSError * error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断文件是否存在
    if([fileManager fileExistsAtPath:tempAudioPath]){ //如果不存在
        
        if([fileManager fileExistsAtPath:savedAudioPath]){ //如果不存在
            [fileManager removeItemAtPath:savedAudioPath error:&error];
        }
        if ([fileManager moveItemAtPath:tempAudioPath toPath:savedAudioPath error:&error] != YES)
            NSLog(@"Unable to move file: %@", [error localizedDescription]);
        else{
            saveAudioBtn.enabled = false;
            tempAudioPath = savedAudioPath;
            [[XBToastManager ShardInstance]showtoast:@"保存录音成功"];
        }
    }
    
}

-(void)playQuestionAudio{
    playAudioBtn.selected = true;
    player =[[Commondata sharedInstance]player];
    [player stop];
    if(playSavedAudioBtn.selected){
        playSavedAudioBtn.selected = false;
        [playSavedAudioBtn addTarget:self action:@selector(playRecordingFile) forControlEvents:UIControlEventTouchDown];
        [answerAudioImage stopAnimating];
        answerAudioImage.image = [UIImage imageNamed:@"saved_voice1"];
    }

    
    [playAudioBtn removeTarget:self action:@selector(playQuestionAudio) forControlEvents:UIControlEventTouchDown];
    [self showAudioAction];
}



-(void)showWordAction:(UIButton*)button{
    NSDictionary *subQuestion = questionArray[self.questionIndex];
    
    button.selected = true;
    
    [questionAudioImage removeFromSuperview];
    
   // UILabel *questionContenLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 50, 25, 11)];
    
    questionContenLabel  = [[UILabel alloc] init];
    questionContenLabel.text          = [subQuestion objectForKey:@"Content"];
    questionContenLabel.numberOfLines = 0;// 需要把显示行数设置成无限制
    questionContenLabel.font          = [UIFont systemFontOfSize:17];
    questionContenLabel.textAlignment = NSTextAlignmentLeft;
    CGSize size                = [self sizeWithString:questionContenLabel.text font:questionContenLabel.font cotentType:@"03"];
    questionContenLabel.frame         = CGRectMake(60, 50, size.width, size.height);
    
    [scrollView addSubview:questionContenLabel];
    [button removeTarget:self action:@selector(showWordAction:) forControlEvents:UIControlEventTouchDown];
     [button addTarget:self action:@selector(hideWordAction:) forControlEvents:UIControlEventTouchDown];
}

-(void)hideWordAction:(UIButton*)button{
    button.selected = false;
    [questionContenLabel removeFromSuperview];
    
    [scrollView addSubview:questionAudioImage];
    
    [button removeTarget:self action:@selector(hideWordAction:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(showWordAction:) forControlEvents:UIControlEventTouchDown];
    
}
-(void)showQuestionExplainAction{
    [self addExpalinView];
}

-(void)addExpalinView{
    [self dismissKeybordAction];
    explainView = [[UIView alloc]init];
    CGFloat tempCurrentY = 0;
    UIImageView* imgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mainWidth,1)];
    imgLine.backgroundColor = [UIColor hexFloatColor:@"00aeee"];
    [explainView addSubview:imgLine];
    UIImageView* imgLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, mainWidth,1)];
    imgLine2.backgroundColor = [UIColor hexFloatColor:@"00aeee"];
    [explainView addSubview:imgLine2];

    tempCurrentY = 5;
    UILabel *explainTittle  = [[UILabel alloc] initWithFrame:CGRectMake(10, tempCurrentY, 100, 20)];
    explainTittle.text = @"试题详解";
    explainTittle.font = [UIFont systemFontOfSize:16];

    tempCurrentY = tempCurrentY +35;
    [explainView addSubview:explainTittle];
    
    explainView.backgroundColor = [UIColor hexFloatColor:@"eefbff"];
    if(currentY+150<mainHeight-114){
        explainView.frame = CGRectMake(0, mainHeight-150-179, mainHeight, 150);
        scrollView.contentSize = CGSizeMake(mainWidth,  mainHeight);
    }else{
        explainView.frame = CGRectMake(0, currentY, mainHeight, 150);
        scrollView.contentSize = CGSizeMake(mainWidth,  currentY+200+144);
    }
    [scrollView addSubview:explainView];
    
    
    
    NSDictionary *subQuestion = questionArray[self.questionIndex];
    
    NSString *explain = [subQuestion objectForKey:@"Explain"];
    
    if ([self isBlankString:explain]) {
        
        NSArray *array = [subQuestion objectForKey:@"Answer_array"];
        for(NSInteger k=0;k<[array count];k++){
            NSDictionary *dic = array[k];
            if([[dic objectForKey:@"Is_right"] integerValue]==1){
                explain = [dic objectForKey:@"Id"];
                break;
            }
        }
    }
    explain = [NSString stringWithFormat:@"答案:%@",explain];
    UILabel *explainLabel  = [[UILabel alloc] init];
    explainLabel.text          = explain;
    explainLabel.numberOfLines = 0;// 需要把显示行数设置成无限制
    explainLabel.font          = [UIFont systemFontOfSize:14];
    explainLabel.textAlignment = NSTextAlignmentLeft;
    CGSize size                = [self sizeWithString:explainLabel.text font:explainLabel.font cotentType:@"01"];
    explainLabel.frame         = CGRectMake(10, tempCurrentY, size.width, size.height);
    [explainView addSubview:explainLabel];
    
}

-(void)removeExpalinView{
    if (explainView) {
        scrollView.contentSize = CGSizeMake(mainWidth,  self.originContentY-explainView.frame.size.height);
        [explainView removeFromSuperview];
        explainView = nil;
        
    }

}

-(BOOL)IsExplainViewShow{
    if (explainView) {
        return  true;
    }else
        return false;
}

-(void)submmitBtnCompleteBlanksAction{
    submmitBtn.enabled = NO;
    submmitBtn.backgroundColor = [UIColor grayColor];
    //self.view.userInteractionEnabled = NO;
    NSArray *subViews = self.view.subviews;
    for(NSInteger i=0;i<[subViews count];i++){
        UIView *view = subViews[i];
        view.userInteractionEnabled = NO;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeQuestionPage" object:self userInfo:nil];
    //[self dismissKeybordAction];
}

-(void)submmitBtnAction{
   // NSArray *questionArray = [[Commondata sharedInstance]questionArray];
    //NSDictionary * question = questionArray[self.questionIndex];
    NSArray *subQuestionArray = [question objectForKey:@"Sub_array"];
    
    if([selectResultDic count]<[subQuestionArray count]){
        [[XBToastManager ShardInstance]showtoast:@"还有没回答的习题"];
    }else{
        submmitBtn.enabled = NO;
        submmitBtn.backgroundColor = [UIColor grayColor];
        //self.view.userInteractionEnabled = NO;
        NSArray *subViews = scrollView.subviews;
        for(NSInteger i=0;i<[subViews count];i++){
          UIView *view = subViews[i];
            view.userInteractionEnabled = NO;
        }
        [self saveUserAnswer];
    }
    
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
    else if([cotentType isEqualToString:@"02"]){//问题选项
        CGRect rect = [string boundingRectWithSize:CGSizeMake(mainWidth-40, 400)//限制最大的宽度和高度
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                        attributes:@{NSFontAttributeName: font}//传人的字体字典
                                           context:nil];
        return rect.size;
    }else{//问题选项
        CGRect rect = [string boundingRectWithSize:CGSizeMake(mainWidth-65, 400)//限制最大的宽度和高度
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                        attributes:@{NSFontAttributeName: font}//传人的字体字典
                                           context:nil];
        return rect.size;
    }

}

#pragma qcheck delegate
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
    if (checked) {
        checkbox.superview.backgroundColor = [UIColor hexFloatColor:@"d0d0d0"];
        checkbox.userInteractionEnabled = NO;
        
        if(![self.detailType isEqualToString:@"02"]&&![self.detailType isEqualToString:@"03"]){
            QCheckBox *selectResult = [selectResultDic objectForKey:[NSNumber numberWithInteger:checkbox.tag]];
            if (selectResult&&![selectResult isEqual:checkbox]) {
            selectResult.checked = NO;
        }
            [selectResultDic setObject:checkbox forKey:[NSNumber numberWithInteger:checkbox.tag]];
        
            NSArray *subQuestionArray = [question objectForKey:@"Sub_array"];
            if ([subQuestionArray count]==0) {
                [self saveUserAnswer];
            }
       
       // [self saveUserAnswer:[NSNumber numberWithInteger:checkbox.tag] userAnswer:checkbox.titleLabel.text];
        //提示切换
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeQuestionPage" object:self userInfo:nil];
        }
        
    }else{
         checkbox.superview.backgroundColor = [UIColor whiteColor];
         checkbox.userInteractionEnabled = YES;
    }
}

-(void) saveUserAnswer{
   // NSArray *questionArray = [[Commondata sharedInstance]questionArray];
   // NSDictionary * question = questionArray[self.questionIndex];
  //  NSArray *subQuestionArray = [question objectForKey:@"Sub_array"];
    // NSString *descripttion = [question objectForKey:@"Descripttion"];
   
    NSNumber *questId = [commonQuestionHead objectForKey:@"QuestId"];
    
    NSMutableArray *childArrays = [[NSMutableArray alloc]initWithCapacity:4];
    
    for (NSString *key in selectResultDic) {
        
        QCheckBox *qcheck = selectResultDic[key];
                NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:qcheck.userInfo,@"UserAnswer",
                             key,@"ChildQuestId" ,nil];
        [childArrays addObject:dic];

    }
    
    NSDictionary *answerDic  = [[NSDictionary alloc]initWithObjectsAndKeys:questId,@"QuestId",
    type,@"QuestType",childArrays,@"ChildAnswers",nil];
    
    NSMutableDictionary *useAnswerArray = [[Commondata sharedInstance]userAnswerArray];
    [useAnswerArray setObject:answerDic forKey:questId];
    
    //[useAnswerArray addObject:answerDic];
}





-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeQuestionPage" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUnansweredNum" object:nil userInfo:nil];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textInputField
{
    currentTextField = textInputField;
    if ([[Commondata sharedInstance]isAdjustKeyboard])
        return;
    struct utsname systemInfo;
    uname(&systemInfo);
    deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //deviceString = @"iPhone4,1";
    NSLog(@"%@",deviceString);
    
//    //CGRect frame = textField.superview.frame;
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGRect frame = [textInputField convertRect:textInputField.bounds toView:window];
    NSLog(@"当前位置%f",frame.origin.y);
    //NSLog(@"视图%f",self.view.frame.size.height);
    
    contentOffset = self.lazyScrollView.contentOffset.y;
    NSLog(@"当前偏移位置%f",contentOffset);
    [[Commondata sharedInstance]setOrginalOffset:self.lazyScrollView.contentOffset.y];
    if([deviceString isEqual:@"iPhone4,1"]||[deviceString isEqual:@"iPhone3,1"])
        offset = frame.origin.y+120- (self.view.frame.size.height - 253.0-40);//键盘高度216
    else
        offset = frame.origin.y+120- (self.view.frame.size.height - 216);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
     width = self.lazyScrollView.frame.size.width;
     height = self.lazyScrollView.frame.size.height;
    [[Commondata sharedInstance]setOrginalWidth:self.lazyScrollView.frame.size.width];
    [[Commondata sharedInstance]setOrginalHeight:self.lazyScrollView.frame.size.height];
    
    if(offset > 0)
    {
        CGRect rect;
        if (contentOffset>60) {
          rect = CGRectMake(0.0f, -offset-contentOffset,width,height+offset);
        }else
        rect = CGRectMake(0.0f, -offset-contentOffset+60,width,height+offset);
        self.lazyScrollView.frame = rect;
    }
    [[Commondata sharedInstance]setIsAdjustKeyboard:YES];
    
   // (0, mainHeight-174, mainWidth, 60)];

    NSString *message = @"1";
    NSDictionary * postMessage = [NSDictionary dictionaryWithObjectsAndKeys:message, @"infoType",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recevieMsgAciton" object:nil userInfo:postMessage];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textInputField{
    NSLog(@"end editing");
    
    NSMutableArray *completeBlanksAnswer = [[Commondata sharedInstance]completeBlanksAnswer];
    
    completeBlanksAnswer[_questionIndex] = textInputField.text;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUnansweredNum" object:nil userInfo:nil];
    
  //  NSString *message = @"0";
    //NSDictionary * postMessage = [NSDictionary dictionaryWithObjectsAndKeys:message, @"infoType",nil];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeCompleteBanksTarView" object:nil userInfo:postMessage];

    
    //completeBlanksAnswer[textField.tag] = textField.text;
    
}


#pragma mark - LVRecordToolDelegate
- (void)recordTool:(LVRecordTool *)recordTool didstartRecoring:(int)no {
    
}

-(void)dismissKeybordAction{
    if(currentTextField){
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        width = [[Commondata sharedInstance]orginalWidth];
        height = [[Commondata sharedInstance]orginalHeight];
        contentOffset = [[Commondata sharedInstance]orginalOffset];
        CGRect rect = CGRectMake(0.0f, 0.0f, width,height);
        self.lazyScrollView.frame = rect;
        self.lazyScrollView.contentOffset = CGPointMake(0, contentOffset);
        
        
        NSString *message = @"0";
        NSDictionary * postMessage = [NSDictionary dictionaryWithObjectsAndKeys:message, @"infoType",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recevieMsgAciton" object:nil userInfo:postMessage];
        

        [UIView commitAnimations];
   
        [currentTextField resignFirstResponder];
        currentTextField = nil;
         [[Commondata sharedInstance]setIsAdjustKeyboard:NO];
    }
    
}

-(void)dismissKeybordActionRightNow{
    if (currentTextField) {
        [currentTextField resignFirstResponder];
    }
}



#pragma 音频管理

-(void)showAudioAction{
    NSLog(@"test audio");
    
    if(audioIsPlaying){
        [self resumeAdudioAction];
    }else{
        player = [[Commondata sharedInstance]player];
    if([player isPlaying]){
        [player stop];
    }
    
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];//沙盒的Documents路径
    NSLog(@"+++++docPath = %@",docPath);
    NSString *filePath=[docPath  stringByAppendingPathComponent:audioFileName];
    NSLog(@"+++++filePath = %@",filePath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath]){ //如果不存在
        [self downloadQuestionAudio];
    }else{
        //以该路径初始化一个url,然后以url初始化player
        NSError * error;
        NSURL * url = [NSURL fileURLWithPath:filePath];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        player.delegate = self;
        [[Commondata sharedInstance]setPlayer:player];
        if (error) {
            NSLog(@"%@",[error localizedDescription]);
            [fileManager removeItemAtPath:filePath error:&error];
             playAudioBtn.selected = false;
        }else{
            [player prepareToPlay];
            [player play];
            [recordAudioBtn setEnabled:NO];
            audioIsPlaying = true;
            NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"question_voice1"],
                                 [UIImage imageNamed:@"question_voice2"],nil];
            questionAudioImage.animationImages = gifArray; //动画图片数组
            questionAudioImage.animationDuration = 0.3; //执行一次完整动画所需的时长
            //questionAudioImage.animationRepeatCount = 1;  //动画重复次数
            [questionAudioImage startAnimating];
        }
        
        
    }
    }
    
    
}


-(void)pauseAdudioAction{
    if(player){
        if([player isPlaying])
            [player pause];
        playAudioBtn.selected = false;
       // [playAudioBtn setBackgroundImage:[UIImage imageNamed:@"language_btn_listening_pause"] forState:UIControlStateNormal];
        //[mircoPhoneBtn removeTarget:<#(nullable id)#> action:<#(nullable SEL)#> forControlEvents:<#(UIControlEvents)#>]
        
        [playAudioBtn removeTarget:self action:@selector(pauseAdudioAction) forControlEvents:UIControlEventTouchDown];
        
        [playAudioBtn addTarget:self action:@selector(resumeAdudioAction) forControlEvents:UIControlEventTouchDown];
        
    }
}
-(void)resumeAdudioAction{
    if(player){
        [player play];
        playAudioBtn.selected = false;
       // [playAudioBtn setBackgroundImage:[UIImage imageNamed:@"language_btn_listening_play"] forState:UIControlStateNormal];
        //[mircoPhoneBtn removeTarget:<#(nullable id)#> action:<#(nullable SEL)#> forControlEvents:<#(UIControlEvents)#>]
        
        [playAudioBtn removeTarget:self action:@selector(showAudioAction) forControlEvents:UIControlEventTouchDown];
        
        [playAudioBtn addTarget:self action:@selector(pauseAdudioAction) forControlEvents:UIControlEventTouchDown];
        
        
    }
    
}


-(void) downloadQuestionAudio{
    //NSString * audioUrl = @"http://sc.111ttt.com/up/mp3/347508/FCAF062BECD1C24FAED2A355EF51EBDD.mp3";
    
    //    progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    //    progress.frame = CGRectMake(10, 180, mainWidth-40, 20);
    //    progress.progress = 0;
    //    [self.view addSubview:progress];
    
    [[XBToastManager ShardInstance] showprogress:@"加载音频中..."];
    [self.counterLabel pause];
    NSString *urlString = [questionArray[_questionIndex] objectForKey:@"Attachments"];
    //AttachmentsNSString * urlString = @"http://sc.111ttt.com/up/mp3/347508/FCAF062BECD1C24FAED2A355EF51EBDD.mp3";
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    //状态栏加载菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
}


#pragma mark - NSURLConnectionDataDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    receiveData = [[NSMutableData alloc] init];
    allLength = [response expectedContentLength];
    
    self.response = response;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [receiveData appendData:data];
    
    //改变进度条值
    //progress.progress = [receiveData length]/allLength;
    if([receiveData length]/allLength==1){
        [[XBToastManager ShardInstance]hideprogress];
        [self.counterLabel start];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //关闭状态栏菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    /*
     将下载好的数据写入沙盒的Documents下
     */
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];//沙盒的Documents路径
    NSLog(@"+++++docPath = %@",docPath);
    NSString *filePath=[docPath  stringByAppendingPathComponent:audioFileName];
    NSLog(@"+++++filePath = %@",filePath);
    

    [receiveData writeToFile:filePath atomically:YES];
    
    
    
    //以该路径初始化一个url,然后以url初始化player
    NSError * error;
    NSURL * url = [NSURL fileURLWithPath:filePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    player.delegate = self;
    [[Commondata sharedInstance]setPlayer:player];
    if (error) {
        [[XBToastManager ShardInstance]hideprogress];
        NSString *message = @"2";
        NSDictionary * postMessage = [NSDictionary dictionaryWithObjectsAndKeys:message, @"infoType",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recevieMsgAciton" object:nil userInfo:postMessage];
        NSLog(@"%@",[error localizedDescription]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载音频失败,请稍后重试"
                                                        message: nil
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:&error];
        
        playAudioBtn.selected = false;
        [playAudioBtn removeTarget:self action:@selector(showAudioAction) forControlEvents:UIControlEventTouchDown];
        [playAudioBtn addTarget:self action:@selector(playQuestionAudio) forControlEvents:UIControlEventTouchDown];
    }else{
        [player prepareToPlay];
        [player play];
       [recordAudioBtn setEnabled:NO];
        if (playAudioBtn) {
        [playAudioBtn addTarget:self action:@selector(pauseAdudioAction) forControlEvents:UIControlEventTouchDown];
        audioIsPlaying = true;
        NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"question_voice1"],
                             [UIImage imageNamed:@"question_voice2"],nil];
        questionAudioImage.animationImages = gifArray; //动画图片数组
        questionAudioImage.animationDuration = 0.3; //执行一次完整动画所需的时长
        //questionAudioImage.animationRepeatCount = 1;  //动画重复次数
        [questionAudioImage startAnimating];
        }
    }
    
    
    
    
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    //网络连接失败，关闭菊花
   // [[XBToastManager ShardInstance]hideprogress];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [[XBToastManager ShardInstance]hideprogress];
    if ([type isEqualToString:@"12"])
        [self pauseUserfulExpressionAudio];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载音频失败，请检查网络连接"
                                                    message: nil
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    NSString *message = @"2";
    NSDictionary * postMessage = [NSDictionary dictionaryWithObjectsAndKeys:message, @"infoType",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"recevieMsgAciton" object:nil userInfo:postMessage];

    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
        
    }
    
}

#pragma mark - 录音按钮事件
// 按下
- (void)recordBtnDidTouchDown:(UIButton *)recordBtn {
    player =[[Commondata sharedInstance]player];
    [player stop];

        if(playAudioBtn.selected){
            playAudioBtn.selected = false;
            
            [playAudioBtn addTarget:self action:@selector(showAudioAction) forControlEvents:UIControlEventTouchDown];
            [questionAudioImage stopAnimating];
            questionAudioImage.image = [UIImage imageNamed:@"question_voice1"];
        }
        if(playSavedAudioBtn.selected){
            playSavedAudioBtn.selected = false;
            [playSavedAudioBtn addTarget:self action:@selector(playRecordingFile) forControlEvents:UIControlEventTouchDown];
            [answerAudioImage stopAnimating];
            answerAudioImage.image = [UIImage imageNamed:@"saved_voice1"];
        }
    

   // [questionAudioImage stopAnimating];
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"saved_voice1"],
                         [UIImage imageNamed:@"saved_voice2"],nil];
    answerAudioImage.animationImages = gifArray; //动画图片数组
    answerAudioImage.animationDuration = 0.3; //执行一次完整动画所需的时长
    //questionAudioImage.animationRepeatCount = 1;  //动画重复次数
    [answerAudioImage startAnimating];
    
    
    //[[XBToastManager ShardInstance]showprogress:@"录音中，松手停止"];
    [self.recordTool startRecording];
}

// 点击
- (void)recordBtnDidTouchUpInside:(UIButton *)recordBtn {
    double currentTime = self.recordTool.recorder.currentTime;
    NSLog(@"%lf", currentTime);
    
    saveAudioBtn.enabled = true;
    playSavedAudioBtn.enabled = true;
    [answerAudioImage stopAnimating];
    
    answerAudioImage.image = [UIImage imageNamed:@"saved_voice1"];

    if (currentTime < 1) {
        
        [[XBToastManager ShardInstance]showtoast:@"录音时间太短"];

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.recordTool stopRecording];
            [self.recordTool destructionRecordingFile];
        });
    } else {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self.recordTool stopRecording];
                    NSLog(@"已成功录音");
            
                    //成功后转换文件名
            
                    NSError * error;
                    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                    NSString *filePath = [path stringByAppendingPathComponent:@"lvRecord.caf"];
                   // NSURL * url = [NSURL fileURLWithPath:filePath];
            
                    NSString *questId = [questionArray[_questionIndex] objectForKey:@"Qid"];
                    NSString *tempAudioName =[NSString stringWithFormat:@"%@.caf",questId];
                    tempAudioPath=[path  stringByAppendingPathComponent:tempAudioName];
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    //判断文件是否存在
                    if([fileManager fileExistsAtPath:tempAudioPath]){ //如果不存在
                        [fileManager removeItemAtPath:tempAudioPath error:&error];
                    }
            
                    //判断是否移动
                    if ([fileManager moveItemAtPath:filePath toPath:tempAudioPath error:&error] != YES)
                        NSLog(@"Unable to move file: %@", [error localizedDescription]);
                    else
                        [self.recordTool destructionRecordingFile];
        });
        // 已成功录音
//        NSLog(@"已成功录音");
//        
//        //成功后转换文件名
//        
//        NSError * error;
//        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *filePath = [path stringByAppendingPathComponent:@"lvRecord.caf"];
//       // NSURL * url = [NSURL fileURLWithPath:filePath];
//        
//        NSString *questId = [questionArray[_questionIndex] objectForKey:@"Qid"];
//        NSString *tempAudioName =[NSString stringWithFormat:@"%@.caf",questId];
//        tempAudioPath=[path  stringByAppendingPathComponent:tempAudioName];
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        //判断文件是否存在
//        if([fileManager fileExistsAtPath:tempAudioPath]){ //如果不存在
//            [fileManager removeItemAtPath:tempAudioPath error:&error];
//        }
//        
//        //判断是否移动
//        if ([fileManager moveItemAtPath:filePath toPath:tempAudioPath error:&error] != YES)
//            NSLog(@"Unable to move file: %@", [error localizedDescription]);
//        else
//            [self.recordTool destructionRecordingFile];
           //
//
//        //显示文件目录的内容
//        NSLog(@"Documentsdirectory: %@",
//              [fileManager contentsOfDirectoryAtPath:path error:&error]);
   //
    
    
    
    }
    

    saveAudioBtn.enabled = true;
    playSavedAudioBtn.enabled = true;
    [answerAudioImage stopAnimating];
    
    answerAudioImage.image = [UIImage imageNamed:@"saved_voice1"];

    

}

// 手指从按钮上移除
- (void)recordBtnDidTouchDragExit:(UIButton *)recordBtn {
//   // self.imageView.image = [UIImage imageNamed:@"mic_0"];
//     [answerAudioImage stopAnimating];
//    
//    answerAudioImage.image = [UIImage imageNamed:@"saved_voice1"];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//       // [self.recordTool stopRecording];
//        //[self.recordTool destructionRecordingFile];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //[self alertWithMessage:@"已取消录音"];
//        });
//    });
    
}


#pragma mark - 播放录音

- (void)playRecordingFile{
    
    if(playAudioBtn.selected){
        playAudioBtn.selected = false;
        [playAudioBtn addTarget:self action:@selector(playQuestionAudio) forControlEvents:UIControlEventTouchDown];
        [questionAudioImage stopAnimating];
        questionAudioImage.image = [UIImage imageNamed:@"question_voice1"];
    }
    playSavedAudioBtn.selected = true;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
   // NSError *playerError;
    NSError * error;
    NSURL * url;
    if (tempAudioPath) {
        url = [NSURL fileURLWithPath:tempAudioPath];
    }else url = [NSURL fileURLWithPath:savedAudioPath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    player.delegate = self;
    [[Commondata sharedInstance]setPlayer:player];
    
    
    if (player == nil)
    {
        NSLog(@"ERror creating player: %@", [error description]);
        playSavedAudioBtn.selected = false;
    }
    
  //  [self handleNotification:YES];
    [player play];
    [recordAudioBtn setEnabled:NO];
    
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"saved_voice1"],
                         [UIImage imageNamed:@"saved_voice2"],nil];
    answerAudioImage.animationImages = gifArray; //动画图片数组
    answerAudioImage.animationDuration = 0.3; //执行一次完整动画所需的时长
    //questionAudioImage.animationRepeatCount = 1;  //动画重复次数
    [answerAudioImage startAnimating];
}

-(void)playUserfulExpressionAudio{
    [playAudioBtn sendActionsForControlEvents:UIControlEventTouchDown];
}

-(void)pauseUserfulExpressionAudio{
    [playAudioBtn addTarget:self action:@selector(playQuestionAudio) forControlEvents:UIControlEventTouchDown];
    playAudioBtn.selected = false;
    [questionAudioImage stopAnimating];
    questionAudioImage.image = [UIImage imageNamed:@"question_voice1"];
    
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"播放结束");
    //[self handleNotification:NO];
    audioIsPlaying = false;
    [recordAudioBtn setEnabled:YES];
  if ([type isEqualToString:@"12"]) {
      if (playSavedAudioBtn) {
          playSavedAudioBtn.selected = false;
      }
    playAudioBtn.selected = false;
    [playAudioBtn removeTarget:self action:@selector(showAudioAction) forControlEvents:UIControlEventTouchDown];
    [playAudioBtn addTarget:self action:@selector(playQuestionAudio) forControlEvents:UIControlEventTouchDown];
      [questionAudioImage stopAnimating];
      [answerAudioImage stopAnimating];
      questionAudioImage.image = [UIImage imageNamed:@"question_voice1"];
    //answerAudioImage.image = [UIImage imageNamed:@"saved_voice1"];
  }else{
    NSString *message = @"2";
    NSDictionary * postMessage = [NSDictionary dictionaryWithObjectsAndKeys:message, @"infoType",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"recevieMsgAciton" object:nil userInfo:postMessage];
  }
}
/*
#pragma mark - 监听听筒or扬声器
- (void) handleNotification:(BOOL)state
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:state]; //建议在播放之前设置yes，播放结束设置NO，这个功能是开启红外感应
    
    if(state)//添加监听
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sensorStateChange:) name:@"UIDeviceProximityStateDidChangeNotification"
                                                   object:nil];
    else//移除监听
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceProximityStateDidChangeNotification" object:nil];
}

//处理监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState] == YES)
    {
        NSLog(@"Device is close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else
    {
        NSLog(@"Device is not close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

*/
- (void)playRecordingFile2 {
    //[self.recordTool playRecordingFile];
    
    if([player isPlaying]){
        [player stop];
    }
    
    
    //以该路径初始化一个url,然后以url初始化player
    NSError * error;
    NSURL * url = [NSURL fileURLWithPath:savedAudioPath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    player.delegate = self;
    [[Commondata sharedInstance]setPlayer:player];

    //[self.player play];
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"加载音频出错，请重新录音"
                                                        message: nil
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:savedAudioPath error:&error];
        
    }else{
        [player prepareToPlay];
        [player play];
        //[playAudiBtn setEnabled:NO];
    }

}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}





@end
