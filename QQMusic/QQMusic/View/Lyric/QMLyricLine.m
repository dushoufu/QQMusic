//
//  QMLyricLine.m
//  QQMusic
//
//  Created by AenyMo on 16/4/13.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMLyricLine.h"
#import "UIView+Extension.h"
#import "QMLyricTool.h"
#import "QMLyric.h"

#import "QMMusicPlayer.h"

@interface QMLyricLine ()

/** 已播放的长度比例 */
@property (nonatomic, assign) CGFloat playedScale;


@property (nonatomic, strong) QMMusicPlayer *player;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation QMLyricLine

- (void)awakeFromNib {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateLyric) userInfo:nil repeats:YES];
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    //渲染颜色
    [[UIColor colorWithRed:0 green:205 / 255.0 blue:126 / 255.0 alpha:1.0] set];
    
    //设置渲染宽度
    rect.size.width = self.playedScale * self.width;
    
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

//计算已播放的长度比例
- (void)updateLyric {
    
    //获取当前播放时间
    NSTimeInterval currentTime = self.player.currentTime;
    
    for (NSInteger i = 0; i < self.lyricLines.count; i++) {
        //
        QMLyric *lyric = self.lyricLines[i];
        
        NSTimeInterval nextTime = 0;
        
        if (i == self.lyricLines.count - 1) {
            //
            nextTime = self.player.totalTime;
            
        } else {
            
            QMLyric *nexLyric = self.lyricLines[i+1];
            
            nextTime = nexLyric.time;
        }
        
        if (currentTime > lyric.time && currentTime < nextTime) {
            //
            //显示第一行歌词
            self.text = lyric.lyric;
//            self.playingRow = i;
            
            self.playedScale = (currentTime - lyric.time) / (nextTime - lyric.time);
            
            break;
        }
        
    }
    [self setNeedsDisplay];
}

/** 懒加载播放器 */
- (QMMusicPlayer *)player {
    
    if (_player == nil) {
        //
        _player = [QMMusicPlayer shareMusicPlayer];
    }
    return _player;
}


@end
