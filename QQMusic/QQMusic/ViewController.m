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

#import "QMPlayerController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

/** 歌曲信息 */
@property (nonatomic, strong) NSArray *musics;

/** 播放器控制器 */
@property (nonatomic, strong) QMPlayerController *playerController;

@end

@implementation ViewController

//懒加载播放器界面
- (QMPlayerController *)playerController {
    
    if (_playerController == nil) {
        //
        _playerController = [[QMPlayerController alloc] init];
    }
    return _playerController;
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
    //跳转到播放界面,并且播放音乐
    
    //通过懒加载的方式跳转到播放界面
    [self.playerController showWithIndexNumber:indexPath.row];
    
    
}


@end
