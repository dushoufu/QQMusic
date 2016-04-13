//
//  QMMusicPlayer.h
//  QQMusic
//
//  Created by AenyMo on 16/4/12.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    kQMMusicPlayerStatusPlaying,
    kQMMusicPlayerStatusPause,
} QMMusicPlayerStatus;



@class AVAudioPlayer, QMMusicPlayer, QMMusics;

@protocol QMMusicPlayerDelegate <NSObject>

@optional
//音乐播放状态
- (void)musicPlayer:(QMMusicPlayer *)musicPlayer playingStatus:(QMMusicPlayerStatus)playingStatus;

//切换音乐
- (void)musicPlayer:(QMMusicPlayer *)musicPlayer playingModel:(QMMusics *)playingModel;


@end



@interface QMMusicPlayer : NSObject

/** 代理 */
@property (nonatomic, weak) id<QMMusicPlayerDelegate> delegate;


/** 音乐总时间长度 */
@property (nonatomic, assign) NSTimeInterval totalTime;

/** 当前播放时间 */
@property (nonatomic, assign) NSTimeInterval currentTime;

/** 是否正在播放 */
@property (nonatomic, assign, readonly) BOOL isPlaying;

//通过"单例"创建音乐播放器类
+ (instancetype)shareMusicPlayer;

/** 开始播放音乐 */
- (BOOL)playWithIndexNumber:(NSInteger)IndexNumber;

/** 指定时间播放 */
- (BOOL)playAtTime:(NSTimeInterval)time;

/** 暂停 */
- (BOOL)pause;

/** 播放 */
- (BOOL)play;

/** 下一曲 */
- (void)nextOne;

/** 上一曲 */
- (void)preOne;

@end
