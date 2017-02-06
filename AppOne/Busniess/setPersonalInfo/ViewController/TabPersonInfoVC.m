//
//  TabPersonInfoVC.m
//  AppOne
//
//  Created by lile on 15/9/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "TabPersonInfoVC.h"

#import "PersonVC.h"
#import "setPersonInfo.h"
#import "BEGetUserMessageModel.h"
#import "setPhotoModel.h"
#import "LabelViewCell.h"

@interface TabPersonInfoVC (){
    NSString *filePath;
    UITableView *tbView;
    NSIndexPath *selectedPath;
    UIDatePicker *datePicker;
    UIView      *datePickerView;
    NSIndexPath * datePath;
    CGPoint point;
    NSString *actionSheetType;
    Boolean isPickingPic;
}
@end

@implementation TabPersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight) style:UITableViewStyleGrouped];
    isPickingPic = NO;
    tbView.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
    tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbView.delegate = self;
    tbView.dataSource = self;
    [self.view addSubview:tbView];
    self.title = @"个人信息";
    selectedPath = nil;
    datePicker = nil;
    datePickerView = nil;
    //__weak typeof (self) wSelf = self;

}

-(void)viewDidAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    //tbView.delegate = self;
    //tbView.dataSource = self;
    if (!isPickingPic) {
        [self BEGetUserMessage];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    if ([actionSheetType isEqualToString:@"01"]) {
      
        switch (buttonIndex)
        {
            
            case 0:  //打开照相机拍照
                [self takePhoto];
                isPickingPic = YES;
                break;
                
            case 1:  //打开本地相册
                [self LocalPhoto];
                isPickingPic = YES;
                break;
        }
    }else{
        if (buttonIndex==0)
        [[Commondata sharedInstance]backToLoginVC:self];
    }
   
}
//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES  completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES  completion:nil];
    
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        
        data = UIImageJPEGRepresentation(image, 0.3);
        
        
        NSString *_encodedImageStr = [data base64EncodedStringWithOptions:0];
        //测试
        [[Commondata sharedInstance] setPhoto:_encodedImageStr];
        [tbView reloadData];
        //[item reloadRowWithAnimation:UITableViewRowAnimationNone];
        // [self.userPhotoSection reloadSectionWithAnimation:UITableViewRowAnimationNone];
        
        
        // [self sendInfo];
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        //文件管理器
//        NSFileManager *fileManager = [NSFileManager defaultManager];
        
//        把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
//        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        [data writeToFile:[DocumentsPath stringByAppendingString:@"/image.jpg"] atomically:YES];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.jpg"];
        
        
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        //  UIImageView *smallimage = [[[UIImageView alloc] initWithFrame:
        //                            CGRectMake(50, 120, 40, 40)]];
        
        //smallimage.image = image;
        //加在视图中
        // [self.view addSubview:smallimage];
        
        [self saveUserPhoto];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) textEntered:(NSString*) text{
    LabelViewCell *cell = (LabelViewCell *)[tbView cellForRowAtIndexPath:selectedPath];
    cell.labelContent.text = text;
    NSInteger section = selectedPath.section;
    NSInteger row = selectedPath.row;
    if(section==0&&row==1){
        [[Commondata sharedInstance]setNickname:text];
    }else if (section==1){
        if(row ==0)
            [[Commondata sharedInstance]setSex:text];
        else if(row==1)
            [[Commondata sharedInstance]setBirthday:text];
        else if(row==2)
            [[Commondata sharedInstance]setEmail:text];
        else
            [[Commondata sharedInstance]setTelphone:text];

    }    //[cell reloadInputViews];
    [self submitUserInfoAction];
}


#pragma mark --实现表数数据源
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 0)
        return 2;
    
    if (section==2) {
        return 1;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0&&indexPath.row==0)
    {
        return 80;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
   
    if (section==0){
        if (row==0) {
            static NSString *CellIdentifier = @"PhotoViewCell";
            PhotoViewCell *cell = (PhotoViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
            if(cell == nil){
                cell = [[PhotoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.textLabel.text = @"头像";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.delegate = self;
            if([[Commondata sharedInstance]photo_url]==nil&&filePath==nil){
                cell.userPhoto.layer.cornerRadius = cell.userPhoto.frame.size.width / 2;
                cell.userPhoto.clipsToBounds = YES;
                cell.userPhoto.image = [UIImage imageNamed:@"grzx_portrait_default"];
                
            }else if (filePath!=nil){
                cell.userPhoto.layer.cornerRadius = cell.userPhoto.frame.size.width / 2;
                cell.userPhoto.clipsToBounds = YES;
                cell.userPhoto.image = [[UIImage alloc ]initWithContentsOfFile:filePath];
                
            }else{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   // UIImage* image =  [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://images.china.cn/attachement/jpg/site1000/20150720/002564bb43f11716c05b09.jpg"]]];
                    Commondata *data = [Commondata sharedInstance];
                    
                    NSString *photo_url       = @"http://211.101.20.203";
                    if(![self isBlankString:[data photo_url]]){
                      photo_url = [photo_url stringByAppendingString:[data photo_url]];
                        
                        UIImage* image =  [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photo_url]]];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            
                            cell.userPhoto.layer.cornerRadius = cell.userPhoto.frame.size.width / 2;
                            cell.userPhoto.clipsToBounds = YES;
                            if (image) {
                                cell.userPhoto.image = image;
                            }else
                                cell.userPhoto.image = [UIImage imageNamed:@"grzx_portrait_default"];
                        });
                }else
                    cell.userPhoto.image = [UIImage imageNamed:@"grzx_portrait_default"];

                });
            }
            //  cel.userPhoto.image =
            return  cell;
            
        }else{
            return [self getTableViewCell:@"01" tableView:tableView];
        }
    }else if (section==1){
        if (row ==0)
            return [self getTableViewCell:@"02" tableView:tableView];
        else if (row==1)
            return [self getTableViewCell:@"07" tableView:tableView];
        else if (row==2)
            return [self getTableViewCell:@"03" tableView:tableView];
        else
            return [self getTableViewCell:@"04" tableView:tableView];
    }else{
        
        static NSString *CellIdentifier = @"QuitViewCell";
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        UILabel *quitLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainWidth/2-50, 0, 100, 44)];
        quitLabel.textAlignment = NSTextAlignmentCenter;
        quitLabel.text = @"退出登录";
        [cell.contentView addSubview:quitLabel];
    

        return cell;
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedPath = indexPath;
    
    if(!(indexPath.section==1&&indexPath.row==1)){
        if(datePickerView!=nil){
            tbView.contentOffset=point;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            datePickerView.frame = CGRectMake(0, mainHeight, mainWidth, 260);
            [UIView commitAnimations];
            //[datePickerView removeFromSuperview];
            datePickerView = nil;
            
        }
    }
    if(section == 0){
        if (row==0) {
            myActionSheet = [[UIActionSheet alloc]
                             initWithTitle:nil
                             delegate:self
                             cancelButtonTitle:@"取消"
                             destructiveButtonTitle:nil
                             otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
            
            [myActionSheet showInView:self.view];
            actionSheetType = @"01";
        }else if (row==1){
            PersonVC *vc = [[PersonVC alloc]init];
            vc.inputValue = [self checkInputStringRetrunEmpty:[[Commondata sharedInstance]nickname]];
            vc.tableType = @"01";
            vc.detailType = @"01";
            vc.delegate = self;
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = @"设置昵称";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }else if (section==1){
        if (row==0) {
            PersonVC *vc = [[PersonVC alloc]init];
            NSArray * option = [[NSArray alloc]initWithObjects:@"男",@"女", nil];
            vc.inputValue = [self checkInputStringRetrunEmpty:[[Commondata sharedInstance]sex]];
            vc.tableType = @"02";
            vc.delegate = self;
            vc.option = option;
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = @"设置性别";
            [self.navigationController pushViewController:vc animated:YES];
        }else if (row==1) {
            [self showDatePicker:indexPath];
            
        }else if (row==2) {
            PersonVC *vc = [[PersonVC alloc]init];
            vc.inputValue = [self checkInputStringRetrunEmpty:[[Commondata sharedInstance]email]];
            vc.tableType = @"01";
            vc.detailType = @"02";
            vc.delegate = self;
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = @"设置邮箱";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            
        }else if (row==3) {
            PersonVC *vc = [[PersonVC alloc]init];
            vc.inputValue = [self checkInputStringRetrunEmpty:[[Commondata sharedInstance]telphone]];
            vc.tableType = @"01";
            vc.detailType = @"03";
            vc.delegate = self;
            vc.title = @"设置手机";
            vc.hidesBottomBarWhenPushed = YES;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        }
        
    }else if (section==2){
        //退出
        
        myActionSheet = [[UIActionSheet alloc]
                         initWithTitle:@"是否确认退出本次登录"
                         delegate:self
                         cancelButtonTitle:@"取消"
                         destructiveButtonTitle:nil
                         otherButtonTitles: @"退出登录",nil];
        
        [myActionSheet showInView:self.view];
        actionSheetType = @"02";
    }
    
    
}

-(UITableViewCell*) getTableViewCell:(NSString*)cellType tableView:(UITableView *)tableView{
    
    static NSString *CellIdentifier = @"LabelViewCell";
    LabelViewCell *cell = (LabelViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[LabelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if([cellType isEqualToString:@"01"]){
        cell.textLabel.text = @"昵称";
        cell.labelContent.text = [self checkInputString:[[Commondata sharedInstance]nickname]];
        //NSLog(@"label ==%@",cell.labelContent.text);
    }else if ([cellType isEqualToString:@"02"]){
        cell.textLabel.text = @"性别";
        cell.labelContent.text = [self checkInputString:[[Commondata sharedInstance]sex]];
        // cell.labelContent.text = [[Commondata sharedInstance]sex];
    }else if ([cellType isEqualToString:@"03"]){
        cell.textLabel.text = @"邮箱";
        cell.labelContent.text = [self checkInputString:[[Commondata sharedInstance]email]];
    }else if ([cellType isEqualToString:@"04"]){
        cell.textLabel.text = @"手机";
        cell.labelContent.text = [self checkInputString:[[Commondata sharedInstance]telphone]];
    }else if ([cellType isEqualToString:@"05"]){
        cell.textLabel.text = @"考试地区";
        cell.labelContent.text = [self checkInputString:[[Commondata sharedInstance]district]];
        
    }else if ([cellType isEqualToString:@"06"]){
        cell.textLabel.text = @"考试时间";
        cell.labelContent.text = [self checkInputString:[[Commondata sharedInstance]exam_time]];
    }else if ([cellType isEqualToString:@"07"]){
        cell.textLabel.text = @"生日";
        cell.labelContent.text = [self checkInputString:[[Commondata sharedInstance]birthday]];
    }
    return cell;
    
}
-(NSString *)checkInputString:(NSString*)string{
    if ([self isBlankString:string]) {
        return @"暂无";
    }else
        return string;
}

-(NSString *)checkInputStringRetrunEmpty:(NSString*)string{
    if ([self isBlankString:string]) {
        return @"";
    }else
        return string;
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

- (void)chooseDate:(UIDatePicker *)sender {
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:selectedDate];
    LabelViewCell *cell = (LabelViewCell *)[tbView cellForRowAtIndexPath:selectedPath];
    cell.labelContent.text = dateString;
    [[Commondata sharedInstance]setBirthday:dateString];
    
}

-(void)submitUserInfoAction{
    //NSDictionary *personInfo = [NSDictionary dictionaryWithObjectsAndKeys:[[Commondata sharedInstance]sex],@"sex",[[Commondata sharedInstance]nickname],@"nickname",[[Commondata sharedInstance]examadd],@"examadd",
    //[[Commondata sharedInstance]email],@"email",[[Commondata sharedInstance]telphone],@"telphone",[[Commondata sharedInstance]exam_time],@"examtime",[[Commondata sharedInstance]birthday],@"birthday",nil];//注意用nil结束
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    [[XBToastManager ShardInstance] showprogress];
    setPersonInfo *api = [[setPersonInfo alloc]initWithPersonInfo:username token:token];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"succeed");
        
        NSLog(@"收获的数据:%@",api.responseString);
        
        [[XBToastManager ShardInstance] hideprogress];
        NSData *jsonData = [api.responseString
                            dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"解析后的数据:%@", root);
        
        
        NSString *state = [root objectForKey:@"state"];
        NSString *info = [root objectForKey:@"info"];
        
        if([state intValue]==1){
            NSDictionary *result = [root objectForKey:@"result"];
            NSLog(@"result:%@",result);
            NSLog(@"info:%@",info);
          //  [[XBToastManager ShardInstance] showtoast:info];
             [[XBToastManager ShardInstance] hideprogress];
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
        [[XBToastManager ShardInstance] showtoast:@"连接失败,请稍后重试"];
        
    }];
    
}

-(void) BEGetUserMessage{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    NSLog(@"上传照片token＝＝%@",token);
   // [[XBToastManager ShardInstance] showprogress];
    BEGetUserMessageModel *api = [[BEGetUserMessageModel alloc]initWithUsername:username token:token];
    
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"succeed");
        NSLog(@"get userinfo succeed");
        NSDictionary *root = nil;
        if([api isDataFromCache]){
            root = [api cacheJson];
        }
        else{
            NSData *jsonData = [api.responseString
                                dataUsingEncoding:NSUTF8StringEncoding];
            root             = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        }
        
        NSLog(@"解析后的数据:%@", root);
        
        NSString *state = [root objectForKey:@"state"];
        NSString *info  = [root objectForKey:@"info"];
        
        NSLog(@"info==%@",info);
        if([state intValue]==1){
            NSDictionary *result      = [root objectForKey:@"result"];
            NSLog(@"获取信息:%@",result);
            NSString *nickname        = [result objectForKey:@"nickname"];
            NSString *sex             = [result objectForKey:@"sex"];
            NSString *birthday        = [result objectForKey:@"birthday"];
            NSString *email           = [result objectForKey:@"email"];
            NSString *telphone        = [result objectForKey:@"telphone"];
            NSString *photo_url       = [result objectForKey:@"photo"];
//            photo_url = [photo_url stringByAppendingString:[result objectForKey:@"photo_url"]];
            
         //  NSString *photo_url  = [result objectForKey:@"photo_url"];
            NSString *district        = [result objectForKey:@"district"];
            NSString *exam_time       = [result objectForKey:@"exam_time"];
            NSNumber *left_time       = [result objectForKey:@"left_time"];
            NSString *passing_percent = [result objectForKey:@"passing_percent"];
            
            
           // photo_url = [@"http://211.101.20.203" stringByAppendingString:photo_url];
            Commondata *data = [Commondata sharedInstance];
            [data setEmail:email];
            [data setBirthday:birthday];
            [data setNickname:nickname];
            [data setTelphone:telphone];
            [data setPhoto_url:photo_url];
            [data setDistrict:district];
            [data setExam_time:exam_time];
            [data setLeft_time:[left_time stringValue]];
            [data setPassing_percent:passing_percent];
            [data setSex:sex];
            [tbView reloadData];
            [[XBToastManager ShardInstance] hideprogress];
            
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
        [[XBToastManager ShardInstance] showtoast:@"连接网络失败，请稍候重试"];
        
    }];
}

-(void)saveUserPhoto
{
    NSLog(@"发送图片");
    [[XBToastManager ShardInstance] showprogress];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    
    NSLog(@"上传照片token＝＝%@",token);
    setPhotoModel *api = [[setPhotoModel alloc] initWithUsername:username token:token photo:[[Commondata sharedInstance]photo]];
    
    
   // NSLog(@"photo:%@",[[Commondata sharedInstance]photo]);
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"succeed");
        NSDictionary *root =nil;
        isPickingPic = NO;
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
            NSDictionary *result = [root objectForKey:@"result"];
            NSString *token =[result objectForKey:@"token"];
            NSLog(@"token:%@",token);
            
            filePath=nil;
            [[XBToastManager ShardInstance] hideprogress];
            [[XBToastManager ShardInstance] showtoast:@"修改头像成功"];
            // [self clearAction:nil];
            
        }else
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
        isPickingPic = NO;
    }];
    
}

#pragma 设置datepicker
-(void)showDatePicker:(NSIndexPath*)indexPath{
    if (datePickerView==nil) {
        
        UITableViewCell * cell = [tbView cellForRowAtIndexPath:indexPath];
        point = [tbView contentOffset];//在内容视图的起源到滚动视图的原点偏移。
        
        NSLog(@"point %f",point.y);
        
        datePicker = [[UIDatePicker alloc] init];
        
        CGFloat offset = mainHeight -cell.frame.origin.y-44 -datePicker.bounds.size.height-point.y-50-44;
        
        if (offset<0)
        {
            offset = mainHeight - (cell.frame.origin.y - tbView.contentOffset.y) -216-44;
            tbView.contentOffset=CGPointMake(0, -offset+50+44);
        }
        if (![self isBlankString:[[Commondata sharedInstance]birthday]]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date=[formatter dateFromString:[[Commondata sharedInstance]birthday]];
            datePicker.date = date;
        }
        
        
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.backgroundColor = [UIColor whiteColor];
        //self.datePicker.minuteInterval = 30;
        [datePicker addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
        
        
        //datePicker.frame = CGRectMake(0, mainHeight, mainWidth, 216);
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        datePicker.frame = CGRectMake(0, 44, mainWidth, 216);
        datePickerView = [[UIView alloc]initWithFrame:CGRectMake(0, mainHeight, mainWidth, 260)];
        [datePickerView addSubview:datePicker];
        
        
        //创建工具条
        UIToolbar *toolbar=[[UIToolbar alloc]init];
        //设置工具条的颜色
        toolbar.barTintColor=[UIColor grayColor];
        //设置工具条的frame
        toolbar.frame=CGRectMake(0, 0, mainWidth, 44);
        
        
        
        //给工具条添加按钮
        //   UIBarButtonItem *item0=[[UIBarButtonItem alloc]initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(click) ];
        // UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *item3=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(fininshDatePickerAction)];
        
        toolbar.items = @[item2, item2, item3];
        
        
        [datePickerView addSubview:toolbar];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:datePickerView];
        
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        datePickerView.frame = CGRectMake(0, mainHeight-260, mainWidth, 260);
        [UIView commitAnimations];
        
        
        
        //设置文本输入框键盘的辅助视图
        
        
    }else{
        
        tbView.contentOffset=point;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        datePickerView.frame = CGRectMake(0, mainHeight, mainWidth, 260);
        [UIView commitAnimations];
        
        
        // [datePickerView removeFromSuperview];
        datePickerView = nil;
    }

}

#pragma 完成选择

-(void)fininshDatePickerAction{
    
    
    tbView.contentOffset=point;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    datePickerView.frame = CGRectMake(0, mainHeight, mainWidth, 260);
    [UIView commitAnimations];
    
    
    // [datePickerView removeFromSuperview];
    datePickerView = nil;
    
    [self submitUserInfoAction];

}

#pragma mark  -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [[Commondata sharedInstance] backToLoginVC:self];
}



@end
