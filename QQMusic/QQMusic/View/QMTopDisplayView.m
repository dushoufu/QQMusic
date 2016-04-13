//
//  QMTopDisplayView.m
//  QQMusic
//
//  Created by AenyMo on 16/4/12.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMTopDisplayView.h"
#import "QMPlayerController.h"


@interface QMTopDisplayView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *singerLabel;
@property (nonatomic, weak) IBOutlet UIImageView *albumCover;


@end

@implementation QMTopDisplayView

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
- (void)awakeFromNib {
    
//    [self startRotation];
    
    //设置代理
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSLog(@".....");
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //裁剪圆形头像
    self.albumCover.layer.cornerRadius = self.albumCover.bounds.size.width * 0.5;
    
    self.albumCover.clipsToBounds = YES;
}


@end
