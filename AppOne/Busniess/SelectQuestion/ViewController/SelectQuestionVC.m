//
//  SelectQuestionVC.m
//  AppOne
//
//  Created by lile on 15/9/14.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "SelectQuestionVC.h"
#import "BECourseListCell.h"
#import "SelectQuestionTypeCell.h"
#import "BEExerciseModel.h"
#import "SetDevieceUUID.h"
#import "ShowQuestionListVC.h"
#import "QuestionDescriptionVC.h"
#import "AudioPlayManger.h"



@interface SelectQuestionVC (){
    UITableView *tbView;
    NSArray *imageArray;
    NSArray *tittleArray;
    NSArray *specArray;
    NSArray *spec1Array;
    NSArray *questionTypeArray;
    NSDictionary *questionAndImageDic;
    
    
    CGFloat currentY;
    CGFloat allLength;
    
    AVAudioPlayer * player;
    AVAudioSession *session;
    NSMutableData * receiveData;
}


@end

@implementation SelectQuestionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    questionTypeArray = [[Commondata sharedInstance]questionTypeArray];
    // Do any additional setup after loading the view.

    
    //self.tabBarController.hidesBottomBarWhenPushed = YES;
    
    
    questionAndImageDic = [NSDictionary dictionaryWithObjectsAndKeys:@"questiontypes_ico_wxtk",@"08",
                                    @"questiontypes_ico_choice",@"09",@"questiontypes_ico_listening",@"10",@"questiontypes_ico_tiankong",@"11",@"questiontypes_ico_language",@"12",
                                         @"questiontypes_ico_default",@"13",nil];
 
    
    __weak typeof (self) wSelf = self;
   
    //[self initUserInfoData];
    
    [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
        [wSelf.navigationController popViewControllerAnimated:YES];
        // [wSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight) style:UITableViewStyleGrouped];
    tbView.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
    tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tbView];
    tbView.delegate = self;
    tbView.dataSource = self;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    self.title = @"题型选择";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:22], NSFontAttributeName,nil]];
    
   // self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.title = @"";
}
-(void)dealloc{
    [[Commondata sharedInstance]setQuestionTypeArray:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark --实现表数数据源
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //[self showEmpty];
    //return 0;
    return [questionTypeArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return cellHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    //return 46*heightRation;
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  
    return 0;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, 46*heightRation)];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth/2-50, 46*heightRation/2-13,100 , 25)];
//    label.text = @"请选择题型";
//    label.font = [UIFont systemFontOfSize:17];
//    label.textColor = [UIColor hexFloatColor:@"cacaca"];
//    view.backgroundColor = [UIColor whiteColor];
//    [view addSubview:label];
//    return view;
//}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    static NSString *CellIdentifier = @"SelectQuestionTypeCell";
    SelectQuestionTypeCell *cell = (SelectQuestionTypeCell*)[tableView
                                            dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[SelectQuestionTypeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CellIdentifier];
    }
    NSDictionary *questionType = questionTypeArray[row];
    NSString *imageName        = [questionAndImageDic objectForKey:
                           [questionType objectForKey:@"TypeType"]];
    if (imageName==nil) {
        imageName = [questionAndImageDic objectForKey:@"13"];
    }
    cell.imageView.image = [UIImage imageNamed:imageName];

    NSString *unitTittle = [questionType objectForKey:@"TypeName"];
    
    CGRect rect = [unitTittle boundingRectWithSize:CGSizeMake(200, 200)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17]}//传人的字体字典
                                       context:nil];
    cell.txtUnitTittle.frame = CGRectMake(50+53*widthRation, cellHeight/2-rect.size.height/2,
                                           rect.size.width, rect.size.height);
    cell.txtUnitTittle.text = unitTittle;
    if (row%2==0) {
        cell.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
    }else{
         cell.backgroundColor = [UIColor whiteColor];
    }
    
    //cell.unitView.backgroundColor = [UIColor redColor];
    
    
    return cell;
    //return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   __typeof (&*self) __weak weakSelf = self;
    NSDictionary *questionTypeDic = questionTypeArray[indexPath.row];
    NSString *questionType = [questionTypeDic objectForKey:@"TypeType"];
    NSNumber *questNumber = [questionTypeDic objectForKey:@"QuestNumber"];
    NSString *typeName = [questionTypeDic objectForKey:@"TypeName"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self getExercise:questionType questNumer:questNumber.integerValue typeName:typeName];
    
    
}


#pragma 获取习题
-(void)getExercise:(NSString *)questionType questNumer:(NSInteger)questNumber typeName:(NSString*)typeName{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    [[XBToastManager ShardInstance] showprogress];
    //self.syllabusId = @"1581";
    NSLog(@"getExercise id =%@",self.syllabusId);
    BEExerciseModel *api = [[BEExerciseModel alloc]initWithUsername:username token:token course_id:@"224" syllabusId:self.syllabusId quest_type:questionType pageIndex:[NSNumber numberWithInteger:0] pageSize:[NSNumber numberWithInteger:30] deviceId:[SetDevieceUUID getDeviceUUID]];
    [[[Commondata sharedInstance]questionArray] removeAllObjects];
    [[[Commondata sharedInstance]commonQuestionHead]removeAllObjects];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"get userinfo succeed");
        NSDictionary *root = nil;
        if([api isDataFromCache]){
            root = [api cacheJson];
        }else{
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        
        
       
        NSLog(@"解析后的数据:%@", root);
        NSString *state = [root objectForKey:@"state"];
        NSString *info = [root objectForKey:@"info"];
        
        NSLog(@"info==%@",info);
        [[XBToastManager ShardInstance] hideprogress];
        if([state intValue]==1){
            NSArray *result = [root objectForKey:@"result"];
        
            if([result count]>0){
                [[[Commondata sharedInstance]commonQuestionHead]removeAllObjects];
                [[[Commondata sharedInstance]questionArray]removeAllObjects];
                [[[Commondata sharedInstance]commonQuestionHead]addEntriesFromDictionary:result[0]];
                NSString *descripttionAudio = [result[0] objectForKey:@"DescripttionAudio"];
                [self downloadQuestionAudio:descripttionAudio];
                
                if([questionType isEqualToString:@"08"]||[questionType isEqualToString:@"11"]){
                    
                    NSArray *answerArray = [result[0] objectForKey:@"Answer_array"];
                    
                    NSArray *subQuestionArray = [result[0] objectForKey:@"Sub_array"];
                    
                    //[[[Commondata sharedInstance]questionArray] addObjectsFromArray:result];
                    NSString *answerId = [answerArray[0] objectForKey:@"Id"];
                    NSArray *array = [answerId componentsSeparatedByString:@"|"]; //从字符A中分隔成2个元素的数组
                    
                    [[[Commondata sharedInstance]questionArray]addObjectsFromArray:
                     array];
                    [[Commondata sharedInstance]setSubQuestionArray:subQuestionArray];
                    [[[Commondata sharedInstance]completeBlanksAnswer]removeAllObjects];
                    for (NSInteger i =0; i<[array count]; i++) {
                        [[[Commondata sharedInstance]completeBlanksAnswer] addObject:@""];
                    }
                    
                    
                }else if ([questionType isEqualToString:@"09"]){
                    
                    NSDictionary * question = [[Commondata sharedInstance]commonQuestionHead];
                    NSArray *subQuestionArray = [question objectForKey:@"Sub_array"];
                    [[[Commondata sharedInstance]questionArray]addObjectsFromArray:subQuestionArray];
                    
                    
                    
                }else if ([questionType isEqualToString:@"10"]){
                    NSDictionary * question = [[Commondata sharedInstance]commonQuestionHead];
                    NSArray *subQuestionArray = [question objectForKey:@"Sub_array"];
                    [[[Commondata sharedInstance]questionArray]addObjectsFromArray:subQuestionArray];
                    
                }else if ([questionType isEqualToString:@"12"]){
                    NSArray *subArray = [result[0] objectForKey:@"Sub_array"];
                    [[[Commondata sharedInstance]questionArray]addObjectsFromArray:subArray];
                }
                
                //    NSDictionary *dic =[[Commondata sharedInstance]commonQuestionHead];
                //NSArray *questionArray = [[Commondata sharedInstance]questionArray];
                if ([[[Commondata sharedInstance]commonQuestionHead] count]>0) {
                    
                    QuestionDescriptionVC *vc =[[QuestionDescriptionVC alloc]init];
                    vc.tittleName = typeName;
                   // vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }else
                    [[XBToastManager ShardInstance] showtoast:@"无可用试题"];

            }else
                 [[XBToastManager ShardInstance] showtoast:@"无可用试题"];
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
        [[XBToastManager ShardInstance] showtoast:@"连接失败"];
        
    }];
}

#pragma mark  -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [[Commondata sharedInstance] backToLoginVC:self];
}


-(void) downloadQuestionAudio: (NSString *)urlString{
    //NSString * audioUrl = @"http://sc.111ttt.com/up/mp3/347508/FCAF062BECD1C24FAED2A355EF51EBDD.mp3";
    
    //    progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    //    progress.frame = CGRectMake(10, 180, mainWidth-40, 20);
    //    progress.progress = 0;
    //    [self.view addSubview:progress];
    
    [[XBToastManager ShardInstance] showprogress:@"加载音频中..."];
    
    NSArray *array = [urlString componentsSeparatedByString:@"/"];
    NSString *fileName = array[[array count]-1];
    
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];//沙盒的Documents路径
    NSLog(@"+++++docPath = %@",docPath);
    
    NSString *filePath=[docPath  stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filePath]){ //如果不存在
        NSURL * url = [NSURL URLWithString:urlString];
        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
        [NSURLConnection connectionWithRequest:urlRequest delegate:self];
        
        //状态栏加载菊花
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }else{
        [[XBToastManager ShardInstance] hideprogress];
        NSError * error;
        NSURL * url = [NSURL fileURLWithPath:filePath];
        //[[AudioPlayManger ShardInstance]initAudioPlayer:url];
        player =[[Commondata sharedInstance]player];
        if (player&&[player isPlaying]) {
            [player pause];
        }
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [[Commondata sharedInstance]setPlayer:player];
        player.delegate= self;
        if (error) {
            NSLog(@"%@",[error localizedDescription]);
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载音频失败,请稍后重试"
            //                                                        message: nil
            //                                                       delegate:self
            //                                              cancelButtonTitle:@"确定"
            //                                              otherButtonTitles:nil];
            //        [alert show];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:filePath error:&error];
            
        }else{
            [player prepareToPlay];
            [player play];
            
        }

    }
        
    
    
    
    
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
       // [self.counterLabel start];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
     [[XBToastManager ShardInstance] hideprogress];
    //关闭状态栏菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    /*
     将下载好的数据写入沙盒的Documents下
     */
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];//沙盒的Documents路径
    NSLog(@"+++++docPath = %@",docPath);
    
    NSString *filePath=[docPath  stringByAppendingPathComponent:self.response.suggestedFilename];
    NSLog(@"+++++filePath = %@",filePath);
    
    
    [receiveData writeToFile:filePath atomically:YES];

    //以该路径初始化一个url,然后以url初始化player
    NSError * error;
    NSURL * url = [NSURL fileURLWithPath:filePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    player.delegate = self;
    [[Commondata sharedInstance]setPlayer:player];
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载音频失败,请稍后重试"
//                                                        message: nil
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:&error];
        
    }else{
        [player prepareToPlay];
        [player play];
        
    }
    
}

#pragma mark - NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
     [[XBToastManager ShardInstance] hideprogress];
    //网络连接失败，关闭菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
   // [[XBToastManager ShardInstance]hideprogress];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载音频失败，请检查网络连接"
//                                                    message: nil
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
    
    
    if (error) {
        NSLog(@"%@",[error localizedDescription]);
        
    }
    
}


@end
