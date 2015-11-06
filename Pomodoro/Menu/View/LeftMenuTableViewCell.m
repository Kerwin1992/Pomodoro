//
//  LeftMenuTableViewCell.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/6.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "LeftMenuTableViewCell.h"

@interface LeftMenuTableViewCell() 

@end

@implementation LeftMenuTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _menuImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_menuImageView];
        
        _menuLabel = [[UILabel alloc]init];
        _menuLabel.font = [UIFont systemFontOfSize:22];
        _menuLabel.textColor = [UIColor blackColor];

        [self.contentView addSubview:_menuLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {

    self.menuImageView.frame = CGRectMake(40, 10, 30, 30);
  
    self.menuLabel.frame = CGRectMake(CGRectGetMaxX(self.menuImageView.frame)+10, 10, 100, 30);
    [super layoutSubviews];
}



@end
