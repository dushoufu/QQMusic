//
//  QMLyricView.m
//  QQMusic
//
//  Created by AenyMo on 16/4/14.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMLyricView.h"
#import "QMLyric.h"
#import "QMMusicPlayer.h"

#import "UIView+Extension.h"

@interface QMLyricView () <UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) QMMusicPlayer *player;

/** 当前播放行 */
@property (nonatomic, assign) CGFloat playingRow;

@end

@implementation QMLyricView

- (QMMusicPlayer *)player {
    
    if (_player == nil) {
        //
        _player = [QMMusicPlayer shareMusicPlayer];
        
        //添加观察者
        [_player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _player;
}

- (instancetype)init {
    
    if (self = [super init]) {
        //
        UITableView *tableView = [[UITableView alloc] init];
        tableView.dataSource = self;
        
        //行高
        tableView.rowHeight = 34;
        //清除背景颜色
        tableView.backgroundColor = [UIColor clearColor];
        //隐藏分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView = tableView;
        [self addSubview:tableView];
        
        //创建一个定时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateLyric) userInfo:nil repeats:YES];
        
    }
    return self;
}



/** 布局子控件 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    self.tableView.frame = CGRectInset(self.bounds, 20, 20);
    
}

#pragma mark - UITableViewDataSource
/** 行 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.lyricLines.count;
    
}

/** 内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lyric"];
    
    if (cell == nil) {
        //
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lyric"];
    }
    QMLyric *lyric = self.lyricLines[indexPath.row];
    
    cell.textLabel.text = lyric.lyric;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if (indexPath.row == self.playingRow) {
        //
        //放大歌词
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:205 / 255.0 blue:126 / 255.0 alpha:1.0];
        
    } else {
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
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
            
            //将歌词滚动到中间 (设置歌词(cell)的偏移量) 34: 行高
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
            [self.tableView reloadData];
            //计算当前一行歌词的播放比例
//            self.playedScale = (currentTime - lyric.time) / (nextTime - lyric.time);
            
            break;  //找到歌词行, 退出循环
        }
        
    }
    
//    NSLog(@"cccccccc");
    
}


- (void)setLyricLines:(NSArray *)lyricLines {
    
    _lyricLines = lyricLines;
    
    self.tableView.contentInset = UIEdgeInsetsMake(self.height * 0.5, 0, self.height * 0.5, 0);
    
    //刷新列表
    [self.tableView reloadData];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
}

/** 监听播放状态 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    //    NSLog(@"%@", change);
    
    if ([change[@"new"] integerValue] == kQMMusicPlayerStatusPlaying) {
        //
        self.timer.fireDate = [NSDate distantPast];
        
    } else if ([change[@"new"] integerValue] == kQMMusicPlayerStatusPause) {
        
        self.timer.fireDate = [NSDate distantFuture];
    }
}

- (void)dealloc {
    
    [self.player removeObserver:self forKeyPath:@"status"];
}


@end
