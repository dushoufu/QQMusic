//
//  QMLyricBaseView.h
//  QQMusic
//
//  Created by AenyMo on 16/4/15.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QMLyricBaseView : UIView

@property (nonatomic, strong) NSArray *lyricLines;

/** 当前播放行 */
@property (nonatomic, assign) CGFloat playingRow;

@end
