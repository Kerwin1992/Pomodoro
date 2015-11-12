//
//  PlanCollectionViewCell.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/9.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "PlanCollectionViewCell.h"
#import "PlanNameModel.h"
#import "Constant.h"

@implementation PlanCollectionViewCell

- (void)awakeFromNib {

    [super awakeFromNib];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor blackColor]CGColor];
    
    self.backgroundColor = [UIColor whiteColor];
    self.planCellLabel.text = nil;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.backgroundColor = [UIColor whiteColor];
    self.planCellLabel.text = nil;
}


- (void)setNameModel:(PlanNameModel *)nameModel {

    _nameModel = nameModel;
    if (nameModel != nil) {
        self.planCellLabel.text = nameModel.name;
    }
}

@end
