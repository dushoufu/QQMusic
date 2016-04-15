//
//  QMMusicPlayer.h
//  QQMusic
//
//  Created by AenyMo on 16/4/12.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <Foundation/Foundation.h>

//NSString * const QMMusicPlayerPlayingChanged = @"QMMusicPlayerPlayingChanged";
//NSString * const QMMusicPlayerStatusPlaying = @"QMMusicPlayerStatusPlaying";
//NSString * const QMMusicPlayerStatusPause = @"QMMusicPlayerStatusPause";


typedef enum : NSUInteger {
    kQMMusicPlayerStatusPlaying,
    kQMMusicPlayerStatusPause,
} QMMusicPlayerStatus;


@interface QMMusicPlayer : NSObject


/** 音乐列表 */
@property (nonatomic, strong) NSArray *musics;

/** 正在播放的索引 */
@property (nonatomic, assign) NSInteger playingIndex;


/** 音乐总时间长度 */
@property (nonatomic, assign) NSTimeInterval totalTime;

/** 当前播放时间 */
@property (nonatomic, assign) NSTimeInterval currentTime;

/** 播放状态 */
@property (nonatomic, assign, readonly) QMMusicPlayerStatus status;

//通过"单例"创建音乐播放器类
+ (instancetype)shareMusicPlayer;

/** 开始播放音乐 */
- (BOOL)playWithIndexNumber:(NSInteger)IndexNumber;


/** 暂停 */
- (BOOL)pause;

/** 播放 */
- (BOOL)play;

/** 下一曲 */
- (void)nextOne;

/** 上一曲 */
- (void)preOne;

@end
