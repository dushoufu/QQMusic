//
//  QMPlayerController.m
//  QQMusic
//
//  Created by AenyMo on 16/4/12.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMPlayerController.h"
#import "QMMusicPlayer.h"
#import "UIView+Extension.h"

#import <AVFoundation/AVFoundation.h>

@interface QMPlayerController ()

@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UIImageView *slderRight;
@property (weak, nonatomic) IBOutlet UIImageView *sliderLeft;
@property (weak, nonatomic) IBOutlet UIImageView *sliderThumb;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;

@property (weak, nonatomic) IBOutlet UIButton *playButton;

#pragma mark - 手势操作
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapPlayGesture;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panPlayGesture;


@property (nonatomic, strong) QMMusicPlayer *player;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation QMPlayerController

- (QMMusicPlayer *)player {
    
    if (_player == nil) {
        //
        _player = [QMMusicPlayer shareMusicPlayer];
    }
    return _player;
}

- (instancetype)init {
    
    if (self = [super init]) {
        //
        //获取主窗口
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        //设置View的大小等于主窗口的大小
        self.view.frame = window.bounds;
        
        //设置默认隐藏View
        self.view.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        
        //添加到主窗口上
        [window addSubview:self.view];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建定时器
    [self createTimer];
}


#pragma mark - 手势播放控制
- (IBAction)tapPlay:(UITapGestureRecognizer *)sender {
    
    //获取当前点
    CGPoint point = [sender locationInView:self.slderRight];
    
    //刷新进度条
//    self.sliderLeft.width = point.x;
    NSTimeInterval time = (point.x / self.slderRight.bounds.size.width) * self.player.player.duration;
    
    //快进歌曲     重新设置当前时间
    self.player.player.currentTime = time;
    
    ;
}

- (IBAction)panPlay:(UIPanGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:self.slderRight];
    
    if (point.x > self.slderRight.width) {
        //
        point.x = self.slderRight.width;
        
    } else if (point.x < 0) {
        
        point.x = 0;
    }
    
    self.sliderLeft.width = point.x;
    self.sliderThumb.centerX = CGRectGetMaxX(self.sliderLeft.frame);
    
    NSTimeInterval time = (point.x / self.slderRight.bounds.size.width) * self.player.player.duration;
    
    //快进歌曲     重新设置当前时间
    self.player.player.currentTime = time;
}

#pragma mark - 播放控制
/** 播放/暂停 */
- (IBAction)play {
    
    //如果 暂停播放 成功
    if ([self.player pause]) {
        //
        //改变按钮状态
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:UIControlStateNormal];
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_play_highlight"] forState:UIControlStateHighlighted];
        
        //停止定时器
        [self.timer invalidate];
        
    } else if ([self.player play]) {
        //播放成功
        //改变按钮状态
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:UIControlStateNormal];
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_pause_highlight"] forState:UIControlStateHighlighted];
        
        //创建定时器
        [self createTimer];
    }
    
    
}

/** 下一曲 */
- (IBAction)next {
    
    [self.player nextOne];
}

/** 上一曲 */
- (IBAction)pre {
    
    [self.player preOne];
}


#pragma mark - 定时器,刷新进度
//创建定时器
- (void)createTimer {
    
    //创建一个定时器,刷新播放进度
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

- (void)updateProgress {
    
    //每隔0.1秒刷新一次进度
    
    //设置时间显示进度
    self.currentTime.text = self.player.currentTime;
    self.totalTime.text = self.player.totalTime;
    
//    NSLog(@"......");
    
    //刷新进度条 (设置滑块的宽度)
    
    CGRect frame = self.sliderLeft.frame;
    frame.size.width = (self.player.currenttime / self.player.totaltime) * self.slderRight.frame.size.width;
    
    self.sliderLeft.frame = frame;
    
    CGPoint center = self.sliderThumb.center;
    center.x = CGRectGetMaxX(frame);
    
    self.sliderThumb.center = center;
    
}


#pragma mark - 跳转控制器
/** 显示控制器 */
- (void)show {
    
    //通过动画的方式显示出窗口
    [UIView animateWithDuration:0.5 animations:^{
        //
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (IBAction)back {
    
    //隐藏控制器
    [UIView animateWithDuration:0.5 animations:^{
        //
        self.view.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
    }];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


@end
