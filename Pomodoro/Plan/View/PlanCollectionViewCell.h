//
//  PlanCollectionViewCell.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/9.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlanNameModel;

@interface PlanCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *planCellLabel;

@property (nonatomic, weak) PlanNameModel *nameModel;

@end
