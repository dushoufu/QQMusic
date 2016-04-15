//
//  QMLyricView.m
//  QQMusic
//
//  Created by AenyMo on 16/4/14.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMLyricView.h"
#import "UIView+Extension.h"
#import "QMLyric.h"

@interface QMLyricView () <UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation QMLyricView

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
        //隐藏指示器
        tableView.showsVerticalScrollIndicator = NO;
        
        self.tableView = tableView;
        [self addSubview:tableView];
        
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
    
    //清除背景颜色
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}

#pragma mark - 重写父类set方法
- (void)setLyricLines:(NSArray *)lyricLines {
    
    [super setLyricLines:lyricLines];
    
    
    //当歌词改变的时候, 初始化tableView的显示界面
    self.tableView.contentInset = UIEdgeInsetsMake(self.height * 0.5, 0, self.height * 0.5, 0);
    
    //刷新列表
    [self.tableView reloadData];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    
}

- (void)setPlayingRow:(CGFloat)playingRow {
    
    [super setPlayingRow:playingRow];
    
    //滚动到该行, 并刷新
    //将歌词滚动到中间 (设置歌词(cell)的偏移量) 34: 行高
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:playingRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    [self.tableView reloadData];
}



@end
