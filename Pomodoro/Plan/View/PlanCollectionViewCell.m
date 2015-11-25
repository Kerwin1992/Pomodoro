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
//        for(NSString *fontfamilyname in [UIFont familyNames])
//        {
//            NSLog(@"family:'%@'",fontfamilyname);
//            for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//            {
//                NSLog(@"\tfont:'%@'",fontName);
//            }
//            NSLog(@"-------------");
//        }
        self.planCellLabel.font = [UIFont fontWithName:@"DFPOP1W5" size:15];
        self.planCellLabel.textColor = [UIColor blueColor];
        self.planCellLabel.text = nameModel.name;
    }
}

@end
