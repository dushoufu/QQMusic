//
//  NSString+Extension.m
//  QQMusic
//
//  Created by AenyMo on 16/4/13.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

#pragma mark - 格式化时间
+ (NSString *)stringByTimeInterval:(NSTimeInterval)timeInterval {
    
    //转换格式
    NSInteger min = (NSInteger)timeInterval / 60;
    NSInteger sec = (NSInteger)timeInterval % 60;
    
    //拼接字符串
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld", min, sec];
    
    return timeStr;

}


#pragma mark - 歌词解析
+ (NSArray *)lyricLinesByLyricString:(NSString *)lyricString {
    
    NSMutableArray *lyricLines = [NSMutableArray array];
    
    //按行 拆分 歌词
    NSArray *tmpArr = [lyricString componentsSeparatedByString:@"\n"];
    
    //遍历数组, 提取需要的信息
    NSString *lineString = nil;
    NSString *newString = nil;
    for (NSInteger i = 0; i < tmpArr.count; i++) {
        //
        lineString = tmpArr[i];
        if (![lineString hasPrefix:@"[0"]) {
            //
            continue;
        }
        //截取歌词
        newString = [lineString substringFromIndex:10];
        
        [lyricLines addObject:newString];
    }
    
    
    return lyricLines;
}

+ (NSArray *)lyricTimesByLyricString:(NSString *)lyricString {
    
    NSMutableArray *lyricLines = [NSMutableArray array];
    
    //按行 拆分 歌词
    NSArray *tmpArr = [lyricString componentsSeparatedByString:@"\n"];
    
    //遍历数组, 提取需要的信息
    NSString *lineString = nil;
    NSString *newString = nil;
    for (NSInteger i = 0; i < tmpArr.count; i++) {
        //
        lineString = tmpArr[i];
        if (![lineString hasPrefix:@"[0"]) {
            //
            continue;
        }
        //截取时间
        newString = [lineString substringToIndex:10];
        
        //转换时间
        NSTimeInterval min = [[newString substringWithRange:NSMakeRange(1, 2)] doubleValue];
        
        NSTimeInterval sec = [[newString substringWithRange:NSMakeRange(4, 2)] doubleValue];
        
        NSTimeInterval dot = [[newString substringWithRange:NSMakeRange(7, 2)] doubleValue] / 100;
        
        NSTimeInterval time = min * 60 + sec + dot;
        
        
        [lyricLines addObject:@(time)];
    }
    
    
    return lyricLines;
}

@end
