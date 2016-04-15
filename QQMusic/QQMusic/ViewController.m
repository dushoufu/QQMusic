//
//  ViewController.m
//  QQMusic
//
//  Created by AenyMo on 16/4/11.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "ViewController.h"
#import "QMMusics.h"
#import "QMMusicCell.h"

#import "QMMiniPlayerController.h"
#import "QMMusicPlayer.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

/** 歌曲信息 */
@property (nonatomic, strong) NSArray *musics;

/** 迷你播放器 */
@property (nonatomic, strong) QMMiniPlayerController *miniPlayer;

/** 播放器 */
@property (nonatomic, strong) QMMusicPlayer *player;

@end

@implementation ViewController

- (QMMusicPlayer *)player {
    
    if (_player == nil) {
        //
        _player = [QMMusicPlayer shareMusicPlayer];
    }
    return _player;
}

//数据懒加载
- (NSArray *)musics {
    
    if (_musics == nil) {
        //
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Musics.plist" ofType:nil];
        
        NSArray *music = [NSArray arrayWithContentsOfFile:filePath];
        
        NSMutableArray *tmp = [NSMutableArray array];
        
        for (NSDictionary *dict in music) {
            //
            QMMusics *music = [QMMusics musicsWithDict:dict];
            
            [tmp addObject:music];
        }
        
        _musics = tmp;
    }
    
    return _musics;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建mini播放器
    QMMiniPlayerController *miniPlayerController = [[QMMiniPlayerController alloc] init];
    
    self.miniPlayer = miniPlayerController;
    
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.musics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //自定义cell
    QMMusicCell *cell = [QMMusicCell musicCellWithTableView:tableView];
    
    cell.musics = self.musics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //播放索引的音乐
    [self.player playWithIndexNumber:indexPath.row];
    
    
}


@end
