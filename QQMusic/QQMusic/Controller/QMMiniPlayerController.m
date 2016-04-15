//
//  QMPlayerBarController.m
//  QQMusic
//
//  Created by AenyMo on 16/4/15.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMMiniPlayerController.h"
#import "UIView+Extension.h"
#import "QMMusicPlayer.h"
#import "QMAnimationTool.h"
#import "QMMusics.h"
#import "QMPlayerController.h"

@interface QMMiniPlayerController ()

@property (weak, nonatomic) IBOutlet UIImageView *miniAlbum;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *playlistButton;

@property (nonatomic, strong) QMPlayerController *playerController;

@property (nonatomic, strong) QMMusicPlayer *player;


@end

@implementation QMMiniPlayerController

- (instancetype)init {
    
    if (self = [super init]) {
        //
        //获取主窗口
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        //设置View的大小等于主窗口的大小
        self.view.width = window.width;
        self.view.height = 50;
        self.view.x = 0;
        self.view.y = window.height - 50;
        
        //添加到主窗口上
        [window addSubview:self.view];
    }
    return self;
}

//懒加载播放器界面
- (QMPlayerController *)playerController {
    
    if (_playerController == nil) {
        //
        _playerController = [[QMPlayerController alloc] init];
    }
    return _playerController;
}

- (QMMusicPlayer *)player {
    
    if (_player == nil) {
        //
        _player = [QMMusicPlayer shareMusicPlayer];
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[QMMusicPlayer shareMusicPlayer] addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听 切换音乐 通知
    [[NSNotificationCenter defaultCenter] addObserverForName:@"QMMusicPlayerPlayingChanged" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        //
        //        NSLog(@"%@", note);
        QMMusics *music = note.userInfo[@"playingModel"];
        
        //设置歌曲信息
        self.titleLabel.text = music.name;
        self.miniAlbum.image = [UIImage imageNamed:music.singerIcon];
        
        [QMAnimationTool startRotation:self.miniAlbum];
    }];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    //切割头像 圆角 效果
    self.miniAlbum.layer.cornerRadius = self.miniAlbum.width * 0.5;
    self.miniAlbum.clipsToBounds = YES;
    
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.playerController show];
    
    NSLog(@"%zd, %zd, %f", event.type, event.subtype, event.timestamp);
}


/** 播放/暂停 */
- (IBAction)playOrPause:(UIButton *)sender {
    
    if ([self.player play]) {
        //
        
    } else if ([self.player pause]) {
        
        
    }
}

/** 播放列表 */
- (IBAction)playlist:(UIButton *)sender {
    
}


#pragma mark - 观察者 方法实现
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([change[@"new"] integerValue] == kQMMusicPlayerStatusPlaying) {
        //
        //改变按钮状态
        [self.playButton setImage:[UIImage imageNamed:@"miniplayer_btn_pause_normal"] forState:UIControlStateNormal];
        [self.playButton setImage:[UIImage imageNamed:@"miniplayer_btn_pause_highlight"] forState:UIControlStateHighlighted];
        
        
        //恢复动画
        [QMAnimationTool resumeRotation:self.miniAlbum];
        
    } else if ([change[@"new"] integerValue] == kQMMusicPlayerStatusPause) {
        
        //改变按钮状态
        [self.playButton setImage:[UIImage imageNamed:@"miniplayer_btn_play_normal"] forState:UIControlStateNormal];
        [self.playButton setImage:[UIImage imageNamed:@"miniplayer_btn_play_highlight"] forState:UIControlStateHighlighted];
        
        
        //暂停动画
        [QMAnimationTool pauseRotation:self.miniAlbum];
    }
}


- (void)dealloc {
    
    NSLog(@"%s", __func__);
    
    //移除观察者
    [[QMMusicPlayer shareMusicPlayer] removeObserver:self forKeyPath:@"status"];
}


@end
