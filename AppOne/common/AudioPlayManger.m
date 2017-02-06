//
//  AudioPlayManger.m
//  AppOne
//
//  Created by lile on 15/12/10.
//  Copyright © 2015年 lile. All rights reserved.
//

#import "AudioPlayManger.h"

@implementation AudioPlayManger{
    AVAudioPlayer * player;
}
static AudioPlayManger *audioPlayManger;
+ (AudioPlayManger *)ShardInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioPlayManger = [[AudioPlayManger alloc] init];
        //[audioPlayManger initAudioPlayer];
    });
    return audioPlayManger;
}

-(void)initAudioPlayer:(NSURL *)url{
    
    NSError * error;
    //NSURL * url = [NSURL fileURLWithPath:filePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    //player =[[AVAudioPlayer alloc]init];

}

-(AVAudioPlayer*)getPlayerInstance{
    return player;
}



@end
