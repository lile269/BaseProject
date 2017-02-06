//
//  TabPersonInfoVC.h
//  AppOne
//
//  Created by lile on 15/9/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "OneBaseVC.h"
#import "PersonVC.h"
#import "PhotoViewCell.h"
@interface TabPersonInfoVC : OneBaseVC<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,ChangeTextViewDelegate,PhotoViewDelegate>{
    UIActionSheet *myActionSheet;
}

@end
