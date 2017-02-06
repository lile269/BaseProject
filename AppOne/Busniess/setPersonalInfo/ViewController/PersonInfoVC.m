//
//  PersonInfoVC.m
//  AppOne
//
//  Created by lile on 15/7/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "PersonInfoVC.h"
#import "setPersonInfo.h"
#import "GetUserInfo.h"
#import "setPhotoModel.h"


@interface PersonInfoVC (){
    NSArray *pickerArray;
    
}
@property (weak, nonatomic  ) IBOutlet UIImageView  *imagePhoto;


@property (strong, nonatomic) IBOutlet UIPickerView *pickerSex;
@property (weak, nonatomic  ) IBOutlet UITextField  *txtSex;

@property (weak, nonatomic  ) IBOutlet UITextField  *txtBirthday;
@property (weak, nonatomic  ) IBOutlet UITextField  *txtEmail;
@property (weak, nonatomic  ) IBOutlet UITextField  *txtNickName;

@property (weak, nonatomic  ) IBOutlet UITextField  *txtTelphone;
@property (weak, nonatomic  ) IBOutlet UITextField  *txtExamTime;
@property (weak, nonatomic  ) IBOutlet UITextField  *txtExamAddress;
@end

@implementation PersonInfoVC
@synthesize txtNickName;
@synthesize pickerSex;
@synthesize txtSex;
@synthesize txtEmail;
@synthesize txtBirthday;
@synthesize txtTelphone;
@synthesize txtExamTime;
@synthesize txtExamAddress;
@synthesize imagePhoto;

-(void) awakeFromNib{
   //    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    //self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    //    UIColor * color = [UIColor whiteColor];
    //
    //    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    //    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    //
    //    //大功告成
    //    self.navigationController.navigationBar.titleTextAttributes = dict;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    pickerArray = [NSArray arrayWithObjects:@"男",@"女",nil];
    // Do any additional setup after loading the view from its nib.
   
    pickerSex.delegate = self;
    pickerSex.dataSource = self;
    
    
    self.tableView.rowHeight = 44.0f;
    
    self.tableView.delegate = self;
    
   // self.navigationItem.title = @"测试";
    //self.navigationItem.backBarButtonItem.title=@"ff";
    
   // self.navigationItem.hidesBackButton= YES;
    Commondata *data =[Commondata sharedInstance];
    if ([self isBlankString:[data nickname]] == NO) {
        txtNickName.text = [data nickname];
    }
    
    if ([self isBlankString:[data sex]] == NO) {
          txtSex.text = [data sex];
    }
    if ([self isBlankString:[data email]] == NO) {
        txtEmail.text = [data email];
    }
    if ([self isBlankString:[data birthday]] == NO) {
        txtBirthday.text = [data birthday];
    }
    if ([self isBlankString:[data telphone]] == NO) {
        txtTelphone.text = [data telphone];
    }
    if ([self isBlankString:[data exam_time]] == NO) {
        txtExamTime.text = [data exam_time];
    }
    if ([self isBlankString:[data examadd]] == NO) {
        txtExamAddress.text = [data examadd];
    }
    if ([self isBlankString:[data photo]] == NO) {
        NSData *_decodedImageData   = [[NSData alloc] initWithBase64EncodedString:[data photo] options:0];
        
        UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
        imagePhoto.image = _decodedImage;
    }

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(infoAction)name:UITextFieldTextDidChangeNotification object:nil];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"personinfo vc dealloc");
    NSString *message = @"userInfo";
    NSDictionary * postMessage = [NSDictionary dictionaryWithObjectsAndKeys:message, @"infoType",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateInfo" object:nil userInfo:postMessage];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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

- (void)infoAction

{
    
    NSLog(@"hhhh");
    
}

-(IBAction)clearAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)submitAction:(id)sender{
    //SetPersonInfoVC *vc = [[SetPersonInfoVC alloc]init];
    //[self.navigationController pushViewController:vc animated:YES];
   /*
    NSDictionary *personInfo = [NSDictionary dictionaryWithObjectsAndKeys:txtSex.text,@"sex",txtNickName.text,@"nickname",txtBirthday.text,@"birthday",txtExamAddress.text,@"examadd",
txtEmail.text,@"email",txtTelphone.text,@"telphone",txtExamTime.text,@"examtime",nil];//注意用nil结束
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    [[XBToastManager ShardInstance] showprogress];
    setPersonInfo *api = [[setPersonInfo alloc]initWithPersonInfo:username token:token personInfo:personInfo];
    
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
        
        if([state intValue]==1){
            Commondata *data = [Commondata sharedInstance];
            [data setEmail:txtEmail.text];
            [data setBirthday:txtBirthday.text];
            [data setNickname:txtNickName.text];
            [data setTelphone:txtTelphone.text];
            [data setExam_time:txtExamTime.text];
            [data setExamadd:txtExamAddress.text];
            [data setSex:txtSex.text];
            
            NSDictionary *result = [root objectForKey:@"result"];
            NSLog(@"result:%@",result);
            
            NSString *info = [root objectForKey:@"info"];
            NSLog(@"info:%@",info);
            [[XBToastManager ShardInstance] showtoast:info];
        }else{
            
            NSString *info = [root objectForKey:@"info"];
            
            [[XBToastManager ShardInstance] showtoast:info];
        }
    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"连接失败,请稍后重试"];
        
    }];
*/
    
    
}

- (void)getUserinfo{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    [[XBToastManager ShardInstance] showprogress];
    GetUserInfo *api = [[GetUserInfo alloc]initWithUsername:username token:token];
    
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
        
        
        [[XBToastManager ShardInstance] hideprogress];
        NSLog(@"解析后的数据:%@", root);
        
        //  NSMutableDictionary *root = [[CJSONDeserializer deserializer] deserialize:jsonData error:&error];
        
        //NSLog(@"解析后的数据:%@", root);
        
        
        
        NSString *state = [root objectForKey:@"state"];
        
        NSString *info = [root objectForKey:@"info"];
        
        NSLog(@"info==%@",info);
        
        if([state intValue]==1){
            NSDictionary *result = [root objectForKey:@"result"];
            NSLog(@"获取信息:%@",result);
            NSString *nickname = [result objectForKey:@"nickname"];
            NSString *sex = [result objectForKey:@"sex"];
            NSString *birthday = [result objectForKey:@"birthday"];
            NSString *email = [result objectForKey:@"email"];
            NSString *telphone = [result objectForKey:@"telphone"];
            NSString *photo = [result objectForKey:@"photo"];
            NSString *district = [result objectForKey:@"district"];
            NSString *exam_time = [result objectForKey:@"district"];
            NSString *left_time = [result objectForKey:@"left_time"];
            NSString *passing_percent = [result objectForKey:@"passing_percent"];
            
            Commondata *data = [Commondata sharedInstance];
            [data setEmail:email];
            [data setBirthday:birthday];
            [data setNickname:nickname];
            [data setTelphone:telphone];
            [data setPhoto:photo];
            [data setDistrict:district];
            [data setExam_time:exam_time];
            [data setLeft_time:left_time];
            [data setPassing_percent:passing_percent];
            [data setSex:sex];
            
            if ([self isBlankString:[data nickname]] == NO) {
                txtNickName.text = [data nickname];
            }
            
            if ([self isBlankString:[data sex]] == NO) {
              //  txtSex.text = [data sex];
            }
            if ([self isBlankString:[data email]] == NO) {
                txtEmail.text = [data email];
            }
            if ([self isBlankString:[data birthday]] == NO) {
                txtBirthday.text = [data birthday];
            }
            if ([self isBlankString:[data telphone]] == NO) {
                txtTelphone.text = [data telphone];
            }
            if ([self isBlankString:[data exam_time]] == NO) {
                txtExamTime.text = [data exam_time];
            }
            if ([self isBlankString:[data examadd]] == NO) {
                txtExamAddress.text = [data examadd];
            }
            if ([self isBlankString:[data photo]] == NO) {
                //NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:[data photo]];
                
                NSData *_decodedImageData = [[NSData alloc] initWithBase64EncodedString:[data photo] options:0];
                
                UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
                imagePhoto.image = _decodedImage;
            }

            
            [[XBToastManager ShardInstance] showtoast:info];
            
            
            
            
        }else{
            
            
            [[XBToastManager ShardInstance] showtoast:@"登录失败，请检查密码"];
        }
    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"连接失败失败"];
        
    }];
    
    
    
}

- (IBAction)setPhotoAction:(id)sender {
    
   // UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"camera" ofType:@"png"]];
    
    
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"取消"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    
    [myActionSheet showInView:self.view];

    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
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
        [picker dismissViewControllerAnimated:YES completion:nil];
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
    [picker dismissViewControllerAnimated:YES completion:nil];
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
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        imagePhoto.image = image;
        //NSString *_encodedImageStr = [data base64EncodedStringWithOptions:0];
        //测试
        
    

        
        
       // [[Commondata sharedInstance] setPhoto:image];
        
        
        
        
        [self sendInfo];
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
      //  UIImageView *smallimage = [[[UIImageView alloc] initWithFrame:
        //                            CGRectMake(50, 120, 40, 40)]];
        
        //smallimage.image = image;
        //加在视图中
       // [self.view addSubview:smallimage];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
     [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendInfo
{
   NSLog(@"发送图片");
    [[XBToastManager ShardInstance] showprogress];
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUsername];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    
    NSLog(@"上传照片token＝＝%@",token);
    setPhotoModel *api = [[setPhotoModel alloc] initWithUsername:username token:token photo:[[Commondata sharedInstance]photo]];
    
    
    NSLog(@"photo:%@",[[Commondata sharedInstance]photo]);
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
        
        if([state intValue]==1){
            NSDictionary *result = [root objectForKey:@"result"];
            NSString *token =[result objectForKey:@"token"];
            NSLog(@"token:%@",token);
            
            
            [[XBToastManager ShardInstance] hideprogress];
            [[XBToastManager ShardInstance] showtoast:@"登陆成功" wait:1];
            [self clearAction:nil];
            
            
            
        }else{
            
            [[XBToastManager ShardInstance] hideprogress];
            [[XBToastManager ShardInstance] showtoast:@"登录失败，请检查密码"];
        }
    } failure:^(YTKBaseRequest *request) {
        // you can use self here, retain cycle won't happen
        NSLog(@"failed");
        [[XBToastManager ShardInstance] hideprogress];
        [[XBToastManager ShardInstance] showtoast:@"连接失败失败"];
        
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma picker

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        myActionSheet = [[UIActionSheet alloc]
                         initWithTitle:nil
                         delegate:self
                         cancelButtonTitle:@"取消"
                         destructiveButtonTitle:nil
                         otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
        
        [myActionSheet showInView:self.view];
    }
    
    if(indexPath.section == 1 && indexPath.row == 0){
        [self submitAction:nil];
    }
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


@end
