//
//  QMLyricBaseView.m
//  QQMusic
//
//  Created by AenyMo on 16/4/15.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMLyricBaseView.h"
#import "QMMusicPlayer.h"
#import "QMLyric.h"


@interface QMLyricBaseView ()

@property (nonatomic, strong) QMMusicPlayer *player;

@end

@implementation QMLyricBaseView

- (instancetype)init {
    
    if (self = [super init]) {
        //
        [[NSNotificationCenter defaultCenter] addObserverForName:@"playerTimerUpdate" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            
            [self updateLyric];
        }];
    }
    return self;
}

- (QMMusicPlayer *)player {
    
    if (_player == nil) {
        //
        _player = [QMMusicPlayer shareMusicPlayer];
    }
    return _player;
}

//刷新歌词 显示进度
- (void)updateLyric {
    
    //获取当前播放时间
    NSTimeInterval currentTime = self.player.currentTime;
    
    
    for (NSInteger i = 0; i < self.lyricLines.count; i++) {
        
        //取出当前行模型
        QMLyric *lyric = self.lyricLines[i];
        
        //下一行歌词播放的时间
        NSTimeInterval nextTime = 0;
        
        //判断是否越界    如果 i 已经是最后一行, 下一行歌词播放的时间 为 歌词的总时间
        if (i == self.lyricLines.count - 1) {
            //
            nextTime = self.player.totalTime;
            
        } else {    //否则取出下一行模型, 对应的时间
            
            QMLyric *nexLyric = self.lyricLines[i+1];
            
            nextTime = nexLyric.time;
        }
        
        //判断该行歌词是否是 需要显示的 (正在播放的)
        if (currentTime > lyric.time && currentTime < nextTime) {
            //
            self.playingRow = i;
            
            
            //计算当前一行歌词的播放比例
            //            self.playedScale = (currentTime - lyric.time) / (nextTime - lyric.time);
            
            break;  //找到歌词行, 退出循环
        }
        
    }
    
//        NSLog(@"cccccccc");
    
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
