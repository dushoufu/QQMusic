//
//  QMAnimationTool.m
//  QQMusic
//
//  Created by AenyMo on 16/4/15.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMAnimationTool.h"

@implementation QMAnimationTool

+ (void)startRotation:(UIView *)view {
    
    //创建动画
    CABasicAnimation *rotateAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    //设置动画属性
    rotateAni.fromValue = 0;
    rotateAni.toValue = @(2 * M_PI);
    rotateAni.duration = 15;
    rotateAni.repeatCount = MAXFLOAT;
    
    rotateAni.removedOnCompletion = NO;
    
    //添加动画
    [view.layer addAnimation:rotateAni forKey:@"rotateAnimation"];
}

+ (void)stopRotation:(UIView *)view {
    //移除动画
    [view.layer removeAnimationForKey:@"rotateAnimation"];
    
}

+ (void)pauseRotation:(UIView *)view {
    
    //记录当前时间点
    CFTimeInterval pauseTime = [view.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //让动画定格在这个时间点
    view.layer.timeOffset = pauseTime;
    
    view.layer.speed = 0;
}

+ (void)resumeRotation:(UIView *)view {
    
    //获取暂停的时间
    CFTimeInterval pauseTime = view.layer.timeOffset;
    
    view.layer.timeOffset = 0;
    view.layer.beginTime = 0;
    view.layer.speed = 1.0;
    
    //计算恢复动画的时间
    CFTimeInterval resumeTime = [view.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    
    view.layer.beginTime = resumeTime;
}


@end
