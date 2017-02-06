//
//  PersonVC.m
//  AppOne
//
//  Created by lile on 15/8/19.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "PersonVC.h"

@interface PersonVC (){
    UITableView *tbView;
    NSIndexPath *checkedPath;
    }
@property (strong, readwrite, nonatomic) UITextField *inputTextField;

@end

@implementation PersonVC
@synthesize inputTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    checkedPath = nil;
     //self.tabBarController.tabBar.hidden = YES;
    
    __weak typeof (self) wSelf = self;
    if ([self.tableType isEqualToString:@"01"]) {
        [self actionCustomLeftBtnWithNrlImage:nil htlImage:nil title:@"取消" action:^{
            // [wSelf.navigationController popViewControllerAnimated:YES];
            [wSelf dismissViewControllerAnimated:YES completion:nil];
        }];
        [self actionCustomRightBtnWithNrlImage:nil htlImage:nil title:@"保存" action:^{
            if([wSelf.delegate respondsToSelector:@selector(textEntered:)])
            {
                
                //send the delegate function with the amount entered by the user
                [wSelf.delegate textEntered:wSelf.inputTextField.text];
            }
            //[[Commondata sharedInstance]setNickname:wSelf.inputTextField.text];
            //NSLog(@"commm%@",[[Commondata sharedInstance]nickname]);
            [wSelf dismissViewControllerAnimated:YES completion:nil];
        }];

    }else{
        [self actionCustomLeftBtnWithNrlImage:@"btnback" htlImage:@"btnback" title:@"" action:^{
             [wSelf.navigationController popViewControllerAnimated:YES];
            //[wSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    
    
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight) style:UITableViewStyleGrouped];
    tbView.backgroundColor = [UIColor hexFloatColor:@"f8f8f8"];
    tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tbView];
    tbView.delegate = self;
    tbView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"person della %@",inputTextField.text);
    
    
}

#pragma mark --实现表数数据源
#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.tableType isEqualToString:@"01"])
        return 1;
    else
        return [self.option count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.tableType isEqualToString:@"01"]){
        static NSString *CellIdentifier = @"SubContentCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
        inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(10,0,mainWidth-10,44)];
        inputTextField.clearButtonMode = YES;
        inputTextField.text = self.inputValue;
        inputTextField.delegate = self;
        [inputTextField becomeFirstResponder];
        [cell addSubview:inputTextField];
        return cell;
    }else{
        static NSString *CellIdentifier = @"SubContentCell";
        UITableViewCell *cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
       // if(self.inputValue isEqualToString:)
        cell.textLabel.text = self.option[indexPath.row];
        if ([cell.textLabel.text isEqualToString:self.inputValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            checkedPath = indexPath;
            
        }else
            cell.accessoryType = UITableViewCellAccessoryNone;

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];

    UITableViewCell* cell1 = [tableView cellForRowAtIndexPath:checkedPath];
    
    if(![indexPath isEqual:checkedPath]){
    
        cell1.accessoryType = UITableViewCellAccessoryNone;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }
    if([self.delegate respondsToSelector:@selector(textEntered:)])
    {
        
        //send the delegate function with the amount entered by the user
        [self.delegate textEntered:cell.textLabel.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
