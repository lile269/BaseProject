//
//  MyFarvoriteVC.m
//  AppOne
//
//  Created by lile on 15/7/27.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "TabFarvoriteVC.h"
#import "getFavoriteModel.h"
#import "FavoriteOrWrongCell.h"
#import "Animations.h"
#import "BaseNoDataView.h"
#import "BaseLoadView.h"
#import "SelectQuestionTypeCell.h"
#import "ShowQuestionListVC.h"
#import "getWrongModel.h"

@interface TabFarvoriteVC (){
    NSArray  * courseList;
    NSString * showType;
  //  DMLazyScrollView * lazyScrollView;
      NSMutableArray *viewControllerArray;
    UITableView *wrongTableView;
    BaseNoDataView      *viewEmpty;
    UILabel* lbl;
    Boolean shiftFlag;
    NSArray *questionArray;
    NSDictionary *questionAndImageDic;
    NSMutableDictionary *farvoriteQuestionType;
    NSMutableDictionary *allQuestionArray;
    NSMutableArray *farvoriteQuestionTypeArray;
    NSDictionary *questionType;
    NSMutableArray *resultArray;
   
}
@property (copy, nonatomic)  UISegmentedControl *farvoriteOrWrongControl;
@property (copy, nonatomic)  UITableView        *farvoriteTableView;
@property (copy, nonatomic)  UIView *mainView;

@end

@implementation TabFarvoriteVC
@synthesize farvoriteTableView;
@synthesize mainView;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"我的收藏",@"我的错题",nil];
      UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(mainWidth/2-100, 20,200, 35);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = NAVBAR_COLOR;
    
    shiftFlag = NO;
    
    self.navigationItem.title = @"我的收藏";
  //  [segmentedControl:self action:@selector(changeControlAction:):UIControlEventValueChanged];
    [segmentedControl addTarget:self action:@selector(changeControlAction:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, mainWidth*2, mainHeight-130)];

    [self.view addSubview:mainView];
    farvoriteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight-170)];
    farvoriteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainView addSubview:farvoriteTableView];
    
    wrongTableView = [[UITableView alloc] initWithFrame:CGRectMake(mainWidth, 0, mainWidth, mainHeight-170)];
    
    wrongTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainView addSubview:wrongTableView];
    wrongTableView.dataSource = self;
    wrongTableView.delegate = self;
    farvoriteTableView.dataSource = self;
    farvoriteTableView.delegate = self;
    showType = @"02";
    // A little trick for removing the cell separators
    //self.tableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view from its nib.
    //[self showEmpty];
    
    questionAndImageDic = [NSDictionary dictionaryWithObjectsAndKeys:@"questiontypes_ico_wxtk",@"08",@"questiontypes_ico_choice",@"09",@"questiontypes_ico_listening",@"10",@"questiontypes_ico_language",@"11",@"questiontypes_ico_tiankong",@"12",
    @"questiontypes_ico_default",@"13",nil];
    
    questionType  =[NSDictionary dictionaryWithObjectsAndKeys:@"Complete The Following Blanks",@"08",
                    @"Choose The Best Answer",@"09",@"True Or False",@"10",@"Spot Dictation",@"11",@"Useful Expressions",@"12",
                    @"question default",@"13",nil];
   // farvoriteTableView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    if ([showType isEqualToString:@"02"]) {
        [self getFarvoriteList:@"224"];
    }else
     [self getWrongList:@"224"];
}
-(void)dealloc{
    [[[Commondata sharedInstance]questionArray]removeAllObjects];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  //  NSArray *courseList = [[Commondata sharedInstance] courseList];
    farvoriteQuestionType = [[NSMutableDictionary alloc]initWithCapacity:4];
    farvoriteQuestionTypeArray = [[NSMutableArray alloc]initWithCapacity:4];
    allQuestionArray = [[NSMutableDictionary alloc]initWithCapacity:4];
    for (NSInteger i=0; i<[resultArray count]; i++) {
        NSString *type = [resultArray[i] objectForKey:@"ParentType"];
        NSString *picName = [questionAndImageDic objectForKey:type];
        if (![farvoriteQuestionType objectForKey:type]) {
            [farvoriteQuestionType setObject:picName forKey:type];
            [farvoriteQuestionTypeArray addObject:type];

        }
//        if ([allQuestionArray objectForKey:type]) {
//            NSMutableArray * array = [allQuestionArray objectForKey:type];
//            [array addObject:questionArray[i]];
//        }else{
//            NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:4];
//            [array addObject:questionArray[i]];
//            [allQuestionArray setObject:array forKey:type];
//        }
    }
    
    return [farvoriteQuestionType count];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //   NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    static NSString *CellIdentifier = @"SelectQuestionTypeCell";
    SelectQuestionTypeCell *cell = (SelectQuestionTypeCell*)[tableView
                                                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[SelectQuestionTypeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CellIdentifier];
    }
    
   
    
    NSString *imageName  = [questionAndImageDic objectForKey:farvoriteQuestionTypeArray[row]];
    if (imageName==nil) {
        imageName = [questionAndImageDic objectForKey:@"13"];
    }
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    NSString *unitTittle = [questionType objectForKey:farvoriteQuestionTypeArray[row]];
    
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

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShowQuestionListVC *vc = [[ShowQuestionListVC alloc]init];
    vc.showType =showType; //练习
    //vc.tittleName = typeName;
    NSArray *subArray = [resultArray[indexPath.row] objectForKey:@"Sub_array"];
    
    [[Commondata sharedInstance]setSubQuestionArray:subArray];
   
    [[[Commondata sharedInstance]questionArray]removeAllObjects];
    [[[Commondata sharedInstance]questionArray]addObjectsFromArray:subArray];
    [[[Commondata sharedInstance]commonQuestionHead]setObject:[resultArray[indexPath.row
                                                                           ]objectForKey:@"ParentType"] forKey:@"Type"];
    [[[Commondata sharedInstance]commonQuestionHead]setObject:subArray forKey:@"Sub_array"];
    vc.tittleName = [questionType objectForKey:farvoriteQuestionTypeArray[indexPath.row]];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) getFarvoriteList:(NSString*)course_id {
    [[XBToastManager ShardInstance] showprogress];
    [self hideEmpty];
    [[[Commondata sharedInstance]questionArray]removeAllObjects];
    [[[Commondata sharedInstance]commonQuestionHead]removeAllObjects];
    NSString *token    = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSNumber *course_offset =[NSNumber numberWithInt:0];
    NSNumber *course_num =[NSNumber numberWithInt:1000];
    
    getFavoriteModel *api = [[getFavoriteModel alloc]initWithUsername:username token:token course_id:course_id course_offset:course_offset course_num:course_num];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"get farvorite succeed");
        NSDictionary *root = nil;
        if([api isDataFromCache]){
            root = [api cacheJson];
        }
        else{
            NSLog(@"api%@",api.responseString);
            NSData *jsonData = [api.responseString
                                    dataUsingEncoding:NSUTF8StringEncoding];
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        NSLog(@"解析后的数据:%@", root);
        NSString *state = [root objectForKey:@"state"];
        NSString *info  = [root objectForKey:@"info"];
        NSLog(@"info==%@",info);
        
        [[XBToastManager ShardInstance] hideprogress];
        if([state intValue]==1){
            NSArray *result = [root objectForKey:@"result"];
            resultArray = [[NSMutableArray alloc]initWithCapacity:4];
            [resultArray addObjectsFromArray:result];
            
//            [[[Commondata sharedInstance]questionArray] addObjectsFromArray:result];
//            if ([result count]>0) {
//                 [[[Commondata sharedInstance]commonQuestionHead] addEntriesFromDictionary:result[0]];
//            }
//           
//            questionArray = [[Commondata sharedInstance]questionArray];
            if ([resultArray count]>0) {
                
                //ShowQuestionListVC *vc = [[ShowQuestionListVC alloc]init];
                //vc.hidesBottomBarWhenPushed = YES;
                farvoriteTableView.hidden = NO;
                [farvoriteTableView reloadData];
                [self hideEmpty];
                //[self.navigationController pushViewController:vc animated:YES];
            }else{
                [farvoriteTableView reloadData];
                [self showEmpty];
            }
            
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

-(void) getWrongList:(NSString*)course_id {
    [[XBToastManager ShardInstance] showprogress];
    [self hideEmpty];
    [[[Commondata sharedInstance]questionArray]removeAllObjects];
    [[[Commondata sharedInstance]commonQuestionHead]removeAllObjects];
    
    NSString *token    = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSNumber *course_offset =[NSNumber numberWithInt:0];
    NSNumber *course_num =[NSNumber numberWithInt:1000];
    
     getWrongModel *api = [[getWrongModel alloc]initWithUsername:username token:token course_id:course_id course_offset:course_offset course_num:course_num];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"get farvorite succeed");
        NSDictionary *root = nil;
        if([api isDataFromCache]){
            root = [api cacheJson];
        }
        else{
            NSLog(@"api%@",api.responseString);
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        NSLog(@"解析后的数据:%@", root);
        NSString *state = [root objectForKey:@"state"];
        NSString *info  = [root objectForKey:@"info"];
        NSLog(@"info==%@",info);
        
        [[XBToastManager ShardInstance] hideprogress];
        if([state intValue]==1){
            NSArray *result = [root objectForKey:@"result"];
            resultArray = [[NSMutableArray alloc]initWithCapacity:4];
            [resultArray addObjectsFromArray:result];
            if ([resultArray count]>0) {
             
                //ShowQuestionListVC *vc = [[ShowQuestionListVC alloc]init];
                //vc.hidesBottomBarWhenPushed = YES;
                wrongTableView.hidden = NO;
                [wrongTableView reloadData];
                [self hideEmpty];
                //[self.navigationController pushViewController:vc animated:YES];
            }else{
                //[self showEmpty];
                [wrongTableView reloadData];
                [self showEmpty];
            }
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


- (void)changeControlAction:(id)sender {
    switch([sender selectedSegmentIndex]){
        case 0:
            if(shiftFlag){
                [Animations moveRight:mainView andAnimationDuration:0.3 andWait:YES andLength:mainWidth];
                self.navigationItem.title = @"我的收藏";
                showType = @"02";
                //[mainView setContentOffset:CGPointMake(0, 0)];
                //[farvoriteTableView reloadData];
                [self getFarvoriteList:@"224"];
                shiftFlag = NO;
            }
         
            break;
        case 1:
            if (!shiftFlag) {
                showType = @"03";
                [self getWrongList:@"224"];
                //[wrongTableView reloadData];
                self.navigationItem.title = @"我的错题";
                shiftFlag = YES;
                [Animations moveLeft:mainView andAnimationDuration:0.3 andWait:YES andLength:mainWidth];
            }
           
           // [mainView setContentOffset:CGPointMake(mainWidth, 0)];
            break;
        default:
            showType = @"02";
            [farvoriteTableView reloadData];

    }
}


#pragma override showEmpty

#pragma mark - Empty
- (void)showEmpty
{
    
    lbl = [[UILabel alloc] initWithFrame:CGRectMake(mainWidth/2-50, 164+80, 100, 20)];
    lbl.text = @"暂无记录";
    lbl.textAlignment  = NSTextAlignmentCenter;
    lbl.textColor = [UIColor lightGrayColor];
    lbl.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:lbl];
    
    
//    UIView *emptyView = [[UIView alloc] initWithFrame:mainView.frame]; farvoriteTableView.tableHeaderView = emptyView;
//    emptyView.backgroundColor = [UIColor redColor];
//    farvoriteTableView.userInteractionEnabled = NO;
 
}
-(void)hideEmpty{
    if (lbl)
        [lbl removeFromSuperview];
}

#pragma mark  -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [[Commondata sharedInstance] backToLoginVC:self];
}
@end
