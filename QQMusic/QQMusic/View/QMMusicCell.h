//
//  QMMusicCell.h
//  QQMusic
//
//  Created by AenyMo on 16/4/11.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QMMusics.h"

@interface QMMusicCell : UITableViewCell

@property (nonatomic, strong) QMMusics *musics;

+ (instancetype)musicCellWithTableView:(UITableView *)tableView;

@end
