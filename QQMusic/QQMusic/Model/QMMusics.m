//
//  QMMusics.m
//  QQMusic
//
//  Created by AenyMo on 16/4/11.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMMusics.h"


@implementation QMMusics

+ (instancetype)musicsWithDict:(NSDictionary *)dict {
    
    QMMusics *music = [[QMMusics alloc] init];
    
    [music setValuesForKeysWithDictionary: dict];
    
    return music;
}

@end
