//
//  QMMusicPlayer.m
//  QQMusic
//
//  Created by AenyMo on 16/4/12.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMMusicPlayer.h"
#import <AVFoundation/AVFoundation.h>

#import "QMMusics.h"

static QMMusicPlayer *instance = nil;

@interface QMMusicPlayer () <AVAudioPlayerDelegate>

/** 正在播放的索引 */
@property (nonatomic, assign) NSInteger playingIndex;

@end

@implementation QMMusicPlayer

- (NSArray *)musics {
    
    if (_musics == nil) {
        //
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil];
        
        NSArray *music = [NSArray arrayWithContentsOfFile:filePath];
        
        NSMutableArray *tmp = [NSMutableArray array];
        
        for (NSDictionary *dict in music) {
            //
            QMMusics *music = [QMMusics musicsWithDict:dict];
            
            [tmp addObject:music];
        }
        
        _musics = tmp;
        
    }
    return _musics;
}


- (void)setPlayingIndex:(NSInteger)playingIndex {
    
    if (_playingIndex == playingIndex) {
        return;
    }
    
    _playingIndex = playingIndex;
    //判断是否越界
    if (_playingIndex >= (NSInteger)self.musics.count) {
        //
        _playingIndex = 0;
        
    } else if (_playingIndex < 0) {
        
        _playingIndex = self.musics.count - 1;
    }
    
    //切换到下一曲/上一曲
    [self playWithIndexNumber:_playingIndex];
}


/** 通过索引播放音乐 */
- (BOOL)playWithIndexNumber:(NSInteger)IndexNumber {
    
    //从bundle中加载音乐 (bundle: app的包文件夹中)
    QMMusics *music = self.musics[IndexNumber];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:music.filename ofType:nil];
    
    //将路径转换成URL,并且处理中文路径问题
    NSURL *url = [NSURL fileURLWithPath:[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.delegate = self;
    
    //开始播放音乐 (通知代理)
    [self.delegate musicPlayer:self playingModel:music];
    
    
    //播放音乐
    [self play];
    
    _playingIndex = IndexNumber;
    
    return error ? NO : YES;
}

/** 指定时间播放 */
- (BOOL)playAtTime:(NSTimeInterval)time {
    
    return [self.player playAtTime:time];
}



- (BOOL)pause {
    
    //如果正在播放
    if ([self.player isPlaying]) {
        //暂停
        [self.player pause];
        
        //记录播放状态
        [self.delegate musicPlayer:self playingStatus:kQMMusicPlayerStatusPause];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)play {
    
    //如果没有播放
    if (![self.player isPlaying]) {
        //播放
        [self.player play];
        
        //记录播放状态
        [self.delegate musicPlayer:self playingStatus:kQMMusicPlayerStatusPlaying];
        
        return YES;
    }
    return NO;
}

- (void)nextOne {
    
    self.playingIndex++;
}

- (void)preOne {
    
    self.playingIndex--;
}

/** 通过单例创建播放器 */
+ (instancetype)shareMusicPlayer {
    
    if (instance == nil) {
        //
        //创建播放器对象
        instance = [[self alloc] init];
    }
    
    return instance;
}

#pragma mark - 重写get方法
- (NSTimeInterval)totalTime {
    
    return self.player.duration;
}

- (NSTimeInterval)currentTime {
    
    return self.player.currentTime;
}

//是否正在播放
- (BOOL)isPlaying {
    
    return [self.player isPlaying];
}

#pragma mark - 重写set方法
- (void)setCurrentTime:(NSTimeInterval)currentTime {
    
    self.player.currentTime = currentTime;
}

#pragma mark - 代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    //自动播放下一首
    [self nextOne];
}

@end
