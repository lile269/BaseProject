//
//  AudioPlayManger.h
//  AppOne
//
//  Created by lile on 15/12/10.
//  Copyright © 2015年 lile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>

@interface AudioPlayManger : NSObject
+ (AudioPlayManger *)ShardInstance;
-(void)initAudioPlayer:(NSURL *)url;
-(AVAudioPlayer*)getPlayerInstance;
@end
