//
//  QMMusicCell.m
//  QQMusic
//
//  Created by AenyMo on 16/4/11.
//  Copyright © 2016年 AenyMo. All rights reserved.
//

#import "QMMusicCell.h"

@interface QMMusicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation QMMusicCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        //
        //这个方法是加载xib时调用,子控件还没有加载,不能在这里写设置子控件的代码
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //当xib加载完成后调用这个方法,此时所有的子控件已经加载,可以对子控件进行相关设置
    //设置圆角
    self.imgView.layer.cornerRadius = 24;
    //设置边框
    self.imgView.layer.borderWidth = 5;
    //设置边框颜色
    self.imgView.layer.borderColor = [UIColor yellowColor].CGColor;
    
    //切除圆角
    self.imgView.clipsToBounds = YES;
}

- (void)setMusics:(QMMusics *)musics {
    
    _musics = musics;
    
    //给子控件赋值
    self.imgView.image = [UIImage imageNamed:musics.icon];
    self.titleLabel.text = musics.name;
    self.detailLabel.text = musics.singer;
}

//通过类方法创建自定义cell
+ (instancetype)musicCellWithTableView:(UITableView *)tableView {
    
    //通过tableView的缓存池来创建,如果缓存池中没有,会自动创建新的cell
    QMMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"music"];
    
    return cell;
}



@end
