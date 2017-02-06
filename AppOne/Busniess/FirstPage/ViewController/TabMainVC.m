//
//  TabMainVC.m
//  AppOne
//
//  Created by lile on 15/9/14.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "TabMainVC.h"
#import "CourseListModel.h"
#import "CourseListCell.h"
#import "GetUserInfo.h"
#import "TableViewCell.h"
#import "ProgressView.h"
#import "ExamAndPassingCell.h"
#import "CommonData.h"
#import "CourseListHeaderView.h"
#import "SelectControlCell.h"
#import "BESyllabusIdsModel.h"
#import "SetDevieceUUID.h"
#import "BELoginModel.h"
#import "LoginInfoVC.h"
#import "BECourseListCell.h"
#import "SelectQuestionVC.h"
#import "BEGetQuestTypeModel.h"

@interface TabMainVC (){
     NSArray *colorArray;
    NSMutableArray *syllabusIdsArray;
}

@end

@implementation TabMainVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationItem.title = @"商务英语听说";
    colorArray = [[NSArray alloc]initWithObjects:@"7ec0d3",@"938af4",@"ef674a",@"f68b42",@"31c37d",@"3ecdb4",nil];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight-100) style:UITableViewStyleGrouped];
    self.tableView .backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
    self.tableView .separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.tableView ];
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    self.tableView.rowHeight = 44.0f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setHidden:TRUE];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshBESyllabusIds)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    
    // 设置header
    self.tableView.header = header;
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(receiveMSG:) name:@"updateInfo" object:nil];
    //[self getUserinfo:TRUE];
    
    
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    
    [self loginAction];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateInfo" object:nil];
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
    return [syllabusIdsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 92;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0||section == 1)
        return 0.1;
    
    return 80;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    if (section==1) {
        return 5;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    static NSString *CellIdentifier = @"BECourseListCell";
    BECourseListCell *cell = (BECourseListCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[BECourseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.unitView.backgroundColor = [UIColor hexFloatColor:colorArray[row%6]];
    NSString *tittleText = nil;
    if (row<9) {
        tittleText = [NSString stringWithFormat:@"0%i",row+1];

    }else
        tittleText = [NSString stringWithFormat:@"%i",row+1];
    
    cell.txtUnitLabel.text = tittleText;
    
    NSString * syllabusName = [syllabusIdsArray[row] objectForKey:@"SyllabusName"];
    NSArray *array = [syllabusName componentsSeparatedByString:@"—"]; //从字符A中分隔成2个元素的数组
    if ([array count]>1) {
        
        
        cell.txtUnitTittle.text = array[0];
        cell.txtUnitSpec.text = array[1];
        cell.txtUnitTittle.numberOfLines = 0;// 需要把显示行数设置成无限制
      //  contentLabel.font          = [UIFont systemFontOfSize:17];
        cell.txtUnitTittle.textAlignment = NSTextAlignmentLeft;
        CGSize size                = [self sizeWithString:cell.txtUnitTittle.text font:cell.txtUnitTittle.font cotentType:@"01"];
        cell.txtUnitTittle.frame         = CGRectMake(90*widthRation, 23-size.height/2, size.width, size.height);
        
        cell.txtUnitSpec.frame = CGRectMake(90*widthRation, 56, 300, 20);

        //45-size.width/2
        
        
        //txtUnitSpec = [[UILabel alloc]initWithFrame:CGRectMake(93, 53, 300, 20)];
    }
//    }else{
//        array = [syllabusName componentsSeparatedByString:@" "];
//        if ([array count]>2) {
//            NSInteger subNum = [array count];
//            NSString *txtUnitTittle = array[0];
//            txtUnitTittle =[txtUnitTittle stringByAppendingFormat:@" %@",array[1]];
//            cell.txtUnitTittle.text = txtUnitTittle;
//            
//            NSString *txtUnitSpec = array[2];
//            for(NSInteger i =3;i<subNum;i++)
//            txtUnitSpec = [txtUnitSpec stringByAppendingFormat:@" %@",array[i]];
//            
//            cell.txtUnitSpec.text = txtUnitSpec;
//        }
//    }
    if (row%2==1) {
        cell.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
       // cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }

    //cell.unitView.backgroundColor = [UIColor redColor];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       __typeof (&*self) __weak weakSelf = self;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // TestVC *vc = [[TestVC alloc] init];
    NSLog(@"%@",[syllabusIdsArray[indexPath.row] objectForKey:@"SyllabusId"]);
    [weakSelf BEGetQuestTypeAction:[syllabusIdsArray[indexPath.row] objectForKey:@"SyllabusId"]];
    
}

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 100;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
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




-(void)receiveMSG :(NSNotification *)notification{
    
    NSDictionary* user_info = (NSDictionary *)[notification userInfo];
    NSString* info =[user_info objectForKey:@"infoType"];
    if([info isEqualToString:@"courseInfo"]){
        //[self getCourseList];
    }
    if([info isEqualToString:@"userInfo"]){
       // [self getUserinfo:FALSE];
    }
    
}



- (void)refreshBESyllabusIds{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    BESyllabusIdsModel *api = [[BESyllabusIdsModel alloc] initWithUsername:username courserId:@"224" deviceId:[SetDevieceUUID getDeviceUUID] token:token];
    [self.tableView.header beginRefreshing];
    //CourseListModel *api = [[CourseListModel alloc] initWithUsername:username token:token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"succeed");
        NSDictionary *root =nil;
        if([api isDataFromCache]){
            root = [api cacheJson];
        }else{
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        
        NSLog(@"收获的数据:%@",root);
        
        
        NSString *state = [root objectForKey:@"state"];
        NSString *info = [root objectForKey:@"info"];
        
        if([state intValue]==1){
            //     NSArray *result = [root objectForKey:@"result"];
            
            [[XBToastManager ShardInstance] hideprogress];
            NSArray *array = [root objectForKey:@"result"];
            syllabusIdsArray = [[NSMutableArray alloc]initWithArray:array];
            [self.tableView reloadData];
            
            // 拿到当前的下拉刷新控件，结束刷新状态
            [self.tableView.header endRefreshing];
            
        }else if ([state intValue]==-2){
            
            
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
        [[XBToastManager ShardInstance] showtoast:@"连接失败"];
        
    }];
    
}


- (void)getBESyllabusIds{
    [[XBToastManager ShardInstance] showprogress];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    BESyllabusIdsModel *api = [[BESyllabusIdsModel alloc] initWithUsername:username courserId:@"224" deviceId:[SetDevieceUUID getDeviceUUID] token:token];
    
    //CourseListModel *api = [[CourseListModel alloc] initWithUsername:username token:token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"succeed");
        NSDictionary *root =nil;
        if([api isDataFromCache]){
            root = [api cacheJson];
        }else{
             NSLog(@"api%@",api.responseString);
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        
        NSLog(@"收获的数据:%@",root);
        
        
        NSString *state = [root objectForKey:@"state"];
        NSString *info =[root objectForKey:@"info"];
        [[XBToastManager ShardInstance] hideprogress];
        
        if([state intValue]==1){
       //     NSArray *result = [root objectForKey:@"result"];
            
            
            NSArray *array = [root objectForKey:@"result"];
            
            syllabusIdsArray = [[NSMutableArray alloc]initWithArray:array];
            [self.tableView reloadData];
            [self.tableView setHidden:FALSE];
            
        }else if ([state intValue]==-2){
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                            message: nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else{
            [self.tableView setHidden:FALSE];
            //[[XBToastManager ShardInstance] hideprogress];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                            message: nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //[[XBToastManager ShardInstance] showtoast:@"获取课程信息失败"];
           // [[Commondata sharedInstance]backToLoginVC:self];
            
        }
    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [self.tableView setHidden:FALSE];
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"连接失败"];
        
    }];
    
}

-(void)loginAction{
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    // NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserpwd];
    
    
    BELoginModel *api = [[BELoginModel alloc] initWithUsername:username password:passWord deviceId:[SetDevieceUUID getDeviceUUID]];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"succeed");
        NSDictionary *root =nil;
        if([api isDataFromCache])
        {
            root = [api cacheJson];
        }
        else
        {
            NSLog(@"api%@",api.responseString);
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        
        NSLog(@"收获的数据:%@",root);
        
        NSString *state = [root objectForKey:@"state"];
        NSString *info = [root objectForKey:@"info"];
        
        if([state intValue]==1)
        {
            // NSDictionary *result = [root objectForKey:@"result"];
            //NSString *token =[result objectForKey:@"token"];
            NSString *token =[root objectForKey:@"result"];
            NSLog(@"token:%@",token);
            
            [[Commondata sharedInstance] setLoginState:@"true"];
            [self getBESyllabusIds];
            
            //[self presentViewController:vc animated:YES completion:nil];
            
        }
        else
        {
            
            [[XBToastManager ShardInstance] hideprogress];
           // [[XBToastManager ShardInstance] showtoast:@"登录失败，请检查密码"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                            message: nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //[[XBToastManager ShardInstance] showtoast:@"登录失败，请检查密码" wait:10000];
           // [[Commondata sharedInstance]backToLoginVC:self];
            
    
            
        }
    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"连接失败失败"];
        
    }];
    
}

-(void)BEGetQuestTypeAction:(NSString*)syllabusId{

    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
   // NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserpwd];
    
    [[XBToastManager ShardInstance]showprogress];
    BEGetQuestTypeModel *api = [[BEGetQuestTypeModel alloc] initWithUsername:username syllabusId:
                                syllabusId token:token];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"succeed");
        NSDictionary *root =nil;
        if([api isDataFromCache])
        {
            root = [api cacheJson];
        }
        else
        {
            NSLog(@"api%@",api.responseString);
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        
        NSLog(@"收获的数据:%@",root);
        
        NSString *state = [root objectForKey:@"state"];
        NSString *info = [root objectForKey:@"info"];
        
        if([state intValue]==1)
        {
            NSArray *array = [root objectForKey:@"result"];
            [[Commondata sharedInstance]setQuestionTypeArray:array];
            [[XBToastManager ShardInstance]hideprogress];
            SelectQuestionVC *vc = [[SelectQuestionVC alloc]init];
            vc.syllabusId = syllabusId;
           // vc.hidesBottomBarWhenPushed = YES;
            //[weakSelf.navigationController pushViewController:[[SetPersonInfoVC alloc] init] animated:YES];
            [self.navigationController pushViewController:vc animated:YES];
            
            //[self presentViewController:vc animated:YES completion:nil];
            
        }
        else
        {
            
            [[XBToastManager ShardInstance] hideprogress];
            // [[XBToastManager ShardInstance] showtoast:@"登录失败，请检查密码"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:info
                                                            message: nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            //[[XBToastManager ShardInstance] showtoast:@"登录失败，请检查密码" wait:10000];
            // [[Commondata sharedInstance]backToLoginVC:self];
            
            
            
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

#pragma mark - Navigation

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font cotentType:(NSString *)cotentType
{
    //题干
    if([cotentType isEqualToString:@"01"]){
        CGRect rect = [string boundingRectWithSize:CGSizeMake(mainWidth-107, 100)//限制最大的宽度和高度
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
@end
