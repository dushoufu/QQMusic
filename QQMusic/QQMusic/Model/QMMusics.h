//
//  QMMusics.h
//  QQMusic
//
//  Created by AenyMo on 16/4/11.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMMusics : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *filename;

@property (nonatomic, copy) NSString *lrcname;

@property (nonatomic, copy) NSString *singer;

@property (nonatomic, copy) NSString *singerIcon;

@property (nonatomic, copy) NSString *icon;


+ (instancetype) musicsWithDict:(NSDictionary *)dict;

@end
