//
//  SelectQuestionVC.h
//  AppOne
//
//  Created by lile on 15/9/14.
//  Copyright (c) 2015年 lile. All rights reserved.
//

#import "OneBaseVC.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>

@interface SelectQuestionVC : OneBaseVC<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate>
@property NSString *syllabusId;
@property(nonatomic,retain)   NSURLResponse * response;//用来获取下载的文件的文件名
@end
