//
//  QMPlayerTimer.m
//  QQMusic
//
//  Created by AenyMo on 16/4/15.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMPlayerTimer.h"
#import "QMMusicPlayer.h"

static QMPlayerTimer *instance = nil;

@interface QMPlayerTimer ()
{
    NSTimer *_timer;
}


@end

@implementation QMPlayerTimer

/** 创建一个单例 播放定时器 */
+ (instancetype)sharePlayerTimer {
    
    if (instance == nil) {
        //
        instance = [[self alloc] init];
        
    }
    return instance;
}

- (void)startTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playerTimerUpdate) userInfo:nil repeats:YES];
    
    [[QMMusicPlayer shareMusicPlayer] addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)playerTimerUpdate {
    
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playerTimerUpdate" object:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([change[@"new"] integerValue] == kQMMusicPlayerStatusPlaying) {
        //
        _timer.fireDate = [NSDate distantPast];

        
    } else if ([change[@"new"] integerValue] == kQMMusicPlayerStatusPause) {
        
        _timer.fireDate = [NSDate distantFuture];
    }
}


- (void)dealloc {
    
    [[QMMusicPlayer shareMusicPlayer] removeObserver:self forKeyPath:@"status"];
}


@end
