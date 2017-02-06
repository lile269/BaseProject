//
//  PersonInfoVC.h
//  AppOne
//
//  Created by lile on 15/7/17.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInfoVC : UITableViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    UIActionSheet *myActionSheet;
    //图片2进制路径
    NSString* filePath;
}
- (BOOL) isBlankString:(NSString *)string;
@end
