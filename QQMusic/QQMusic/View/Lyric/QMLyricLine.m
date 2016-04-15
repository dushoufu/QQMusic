//
//  QMLyricLine.m
//  QQMusic
//
//  Created by AenyMo on 16/4/13.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMLyricLine.h"
#import "UIView+Extension.h"
#import "QMLyric.h"

#import "QMMusicPlayer.h"

@interface QMLyricLine ()

/** 已播放的长度比例 */
@property (nonatomic, assign) CGFloat playedScale;


@property (nonatomic, strong) QMMusicPlayer *player;


@end


@implementation QMLyricLine


- (void)awakeFromNib {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"playerTimerUpdate" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        //
        [self updateLyric];
    }];
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
            //显示第一行歌词
            self.text = lyric.lyric;
            
            //计算当前一行歌词的播放比例
            self.playedScale = (currentTime - lyric.time) / (nextTime - lyric.time);
            
            break;  //找到歌词行, 退出循环
        }
        
    }
    //重新渲染
    [self setNeedsDisplay];
    
//    NSLog(@",,,,,,");
}

/** 懒加载播放器 */
- (QMMusicPlayer *)player {
    
    if (_player == nil) {
        //
        _player = [QMMusicPlayer shareMusicPlayer];
        
    }
    return _player;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
