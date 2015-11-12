//
//  AddCollectionViewCell.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/11.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "AddCollectionViewCell.h"

@implementation AddCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
}


@end
