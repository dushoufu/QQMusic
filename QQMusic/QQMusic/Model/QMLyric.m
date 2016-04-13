//
//  QMLyric.m
//  QQMusic
//
//  Created by AenyMo on 16/4/13.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMLyric.h"

@implementation QMLyric

+ (instancetype)lyricWithDict:(NSDictionary *)dict {
    
    QMLyric *lyric = [[self alloc] init];
    
    [lyric setValuesForKeysWithDictionary:dict];
    
    return lyric;
}

@end
