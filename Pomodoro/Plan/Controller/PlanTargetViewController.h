//
//  PlanTargetViewController.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/15.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanNameModel.h"
#import "NameDetailViewController.h"
#import "EditViewController.h"

@class PlanTargetViewController;
@protocol PlanTargetViewControllerDelegate<NSObject>

- (void)refreshItemArray:(PlanNameModel*)planModel;

@end



@interface PlanTargetViewController : UITableViewController<NameDetailViewControllerDelegate,EditViewControllerDelegate,UISearchDisplayDelegate>
@property(nonatomic,weak)id<PlanTargetViewControllerDelegate>delegate;

@property(nonatomic,strong)PlanNameModel *nameModel;

@end
