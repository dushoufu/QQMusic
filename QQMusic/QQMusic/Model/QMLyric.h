//
//  QMLyric.h
//  QQMusic
//
//  Created by AenyMo on 16/4/13.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMLyric : NSObject

/** 时间 */
@property (nonatomic, assign) NSTimeInterval time;

/** 歌词 */
@property (nonatomic, copy) NSString *lyric;


+ (instancetype)lyricWithDict:(NSDictionary *)dict;

@end
