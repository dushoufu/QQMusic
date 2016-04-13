//
//  QMTopDisplayView.h
//  QQMusic
//
//  Created by AenyMo on 16/4/12.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMTopDisplayView : UIView

/** 歌名 */
@property (nonatomic, copy) NSString *title;

/** 歌手 */
@property (nonatomic, copy) NSString *singer;

/** 图片 */
@property (nonatomic, copy) NSString *singerIcon;

/** 歌词 */
@property (nonatomic, copy) NSString *lyric;

/** 开始旋转 */
- (void)startRotation;

/** 停止转动 */
- (void)stopRotation;

/** 暂停动画 */
- (void)pauseRotation;

/** 恢复动画 */
- (void)resumeRotation;

@end
