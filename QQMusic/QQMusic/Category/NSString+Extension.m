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

@end
