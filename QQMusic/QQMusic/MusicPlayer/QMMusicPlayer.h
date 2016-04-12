//
//  QMMusicPlayer.h
//  QQMusic
//
//  Created by AenyMo on 16/4/12.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVAudioPlayer;

@interface QMMusicPlayer : NSObject

/** 播放器 */
@property (nonatomic, strong) AVAudioPlayer *player;

/** 音乐总时间长度 */
@property (nonatomic, copy) NSString *totalTime;

/** 当前播放时间 */
@property (nonatomic, copy) NSString *currentTime;

/** 音乐总时间长度 */
@property (nonatomic, assign) NSTimeInterval totaltime;

/** 当前播放时间 */
@property (nonatomic, assign) NSTimeInterval currenttime;



/** 音乐列表 */
@property (nonatomic, strong) NSArray *musics;

/** 是否正在播放 */
@property (nonatomic, assign, readonly) BOOL isPlaying;

//通过"单例"创建音乐播放器类
+ (instancetype)shareMusicPlayer;

/** 开始播放音乐 */
- (BOOL)playWithFileName:(NSString *)fileName;

- (BOOL)playWithIndexNumber:(NSInteger)IndexNumber;

/** 暂停 */
- (BOOL)pause;

/** 播放 */
- (BOOL)play;

/** 下一曲 */
- (void)nextOne;

/** 上一曲 */
- (void)preOne;

- (BOOL)playAtTime:(NSTimeInterval)time;

@end
