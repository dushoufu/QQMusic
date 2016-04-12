//
//  QMTopDisplayView.m
//  QQMusic
//
//  Created by AenyMo on 16/4/12.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMTopDisplayView.h"
#import "QMPlayerController.h"


@interface QMTopDisplayView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *singerLabel;
@property (nonatomic, weak) IBOutlet UIImageView *albumCover;

@end

@implementation QMTopDisplayView


- (void)awakeFromNib {
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSLog(@".....");
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //裁剪圆形头像
    self.albumCover.layer.cornerRadius = self.albumCover.bounds.size.width * 0.5;
    
    self.albumCover.clipsToBounds = YES;
}


@end
