//
//  QMLyricTool.m
//  QQMusic
//
//  Created by AenyMo on 16/4/13.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMLyricTool.h"
#import "QMLyric.h"
#import "NSString+Extension.h"


@implementation QMLyricTool


+ (NSArray *)lyricLinesWithLyricString:(NSString *)lyricString {
    
    NSArray *lyricLines = [NSString lyricLinesByLyricString:lyricString];

    NSArray *lyricTime = [NSString lyricTimesByLyricString:lyricString];
    
    
    NSMutableArray *lyricModel = [NSMutableArray array];
    
    
    for (NSInteger i = 0; i < lyricLines.count; i++) {
        //

        
        NSDictionary *dict = @{@"lyric" : lyricLines[i],
                               @"time" : lyricTime[i]};
        
        QMLyric *lyric = [QMLyric lyricWithDict:dict];
        
        [lyricModel addObject:lyric];
    }
    
    return lyricModel;
}


@end
