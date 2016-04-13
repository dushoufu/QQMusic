//
//  NSString+Extension.h
//  QQMusic
//
//  Created by AenyMo on 16/4/13.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/** 时间转字符串 */
+ (NSString *)stringByTimeInterval:(NSTimeInterval)timeInterval;

/** 解析歌词 */
+ (NSArray *)lyricLinesByLyricString:(NSString *)lyricString;

+ (NSArray *)lyricTimesByLyricString:(NSString *)lyricString;

@end
