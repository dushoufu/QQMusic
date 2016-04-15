//
//  QMTopDisplayView.m
//  QQMusic
//
//  Created by AenyMo on 16/4/12.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMTopDisplayView.h"
#import "QMPlayerController.h"
#import "QMLyricLine.h"
#import "QMLyricTool.h"
#import "UIView+Extension.h"

#import "QMLyricView.h"


@interface QMTopDisplayView () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *singerLabel;
@property (nonatomic, weak) IBOutlet UIImageView *albumCover;
@property (nonatomic, weak) IBOutlet QMLyricLine *lyricLine;

@property (nonatomic, weak) IBOutlet UIView *leftView;
@property (nonatomic, weak) IBOutlet UIView *rightView;

@property (nonatomic, weak) QMLyricView *lyricView;


@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign) CGPoint currentPoint;


@end

@implementation QMTopDisplayView


- (void)awakeFromNib {
    
    //创建歌词View
    QMLyricView *lyricView = [[QMLyricView alloc] init];
    
    self.lyricView = lyricView;
    
//    lyricView.backgroundColor = [UIColor redColor];
    
    [self.scrollView addSubview:lyricView];
}




#pragma mark - 重写set方法
- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setSinger:(NSString *)singer {
    
    _singer = singer;
    
    self.singerLabel.text = singer;
}

- (void)setSingerIcon:(NSString *)singerIcon {
    
    _singerIcon = singerIcon;
    
    self.albumCover.image = [UIImage imageNamed:singerIcon];
}

- (void)setLyric:(NSString *)lyric {
    
    _lyric = lyric;
    
    //获取歌词路径
    NSString *path = [[NSBundle mainBundle] pathForResource:lyric ofType:nil];
    
    NSString *lrc = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    //解析 并 传递 歌词
    NSArray *lyricLines = [QMLyricTool lyricLinesWithLyricString:lrc];
    self.lyricLine.lyricLines = lyricLines;
    self.lyricView.lyricLines = lyricLines;
    
}

#pragma mark - 动画操作
- (void)startRotation {
    
    //创建动画
    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    //设置动画属性
    rotateAni.fromValue = 0;
    rotateAni.toValue = @(2 * M_PI);
    rotateAni.duration = 15;
    rotateAni.repeatCount = MAXFLOAT;
    
    rotateAni.removedOnCompletion = NO;
    
    //添加动画
    [self.albumCover.layer addAnimation:rotateAni forKey:@"rotateAnimation"];
}

- (void)stopRotation {
    //移除动画
    [self.albumCover.layer removeAnimationForKey:@"rotateAnimation"];

}

- (void)pauseRotation {
    
    //记录当前时间点
    CFTimeInterval pauseTime = [self.albumCover.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //让动画定格在这个时间点
    self.albumCover.layer.timeOffset = pauseTime;
    
    self.albumCover.layer.speed = 0;
}

- (void)resumeRotation {
    
    //获取暂停的时间
    CFTimeInterval pauseTime = self.albumCover.layer.timeOffset;
    
    self.albumCover.layer.timeOffset = 0;
    self.albumCover.layer.beginTime = 0;
    self.albumCover.layer.speed = 1.0;
    
    //计算恢复动画的时间
    CFTimeInterval resumeTime = [self.albumCover.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    
    self.albumCover.layer.beginTime = resumeTime;
}


#pragma mark - 初始化方法

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //裁剪圆形头像
    self.albumCover.layer.cornerRadius = self.albumCover.bounds.size.width * 0.5;
    self.albumCover.clipsToBounds = YES;
    
    //设置scrollView
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 2, self.scrollView.height);
    
    self.lyricView.frame = self.scrollView.bounds;
    self.lyricView.x = CGRectGetMaxX(self.scrollView.frame);
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //获取滚动偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //计算比例值
    CGFloat scale = (self.width - offsetX) / scrollView.width;
    
    //显示和隐藏头像,行歌词,和歌手
    self.lyricLine.alpha = scale;
    self.albumCover.alpha = scale;
    self.singerLabel.alpha = scale;
    self.leftView.alpha = scale;
    self.rightView.alpha = scale;
    
    
    NSLog(@"%f", scrollView.contentOffset.x);
}


@end
