//
//  QMPlayerTimer.h
//  QQMusic
//
//  Created by AenyMo on 16/4/15.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMPlayerTimer : NSObject

/** 创建一个单例 播放定时器 */
+ (instancetype)sharePlayerTimer;

- (void)startTimer;

@end
