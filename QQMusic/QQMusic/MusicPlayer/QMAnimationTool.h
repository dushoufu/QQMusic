//
//  QMAnimationTool.h
//  QQMusic
//
//  Created by AenyMo on 16/4/15.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMAnimationTool : UIView

/** 开始动画 */
+ (void)startRotation:(UIView *)view;

/** 停止动画 */
+ (void)stopRotation:(UIView *)view;

/** 暂停动画 */
+ (void)pauseRotation:(UIView *)view;

/** 恢复动画 */
+ (void)resumeRotation:(UIView *)view;

@end
