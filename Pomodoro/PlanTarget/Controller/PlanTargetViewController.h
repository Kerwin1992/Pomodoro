//
//  PlanTargetViewController.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/15.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanNameModel.h"
#import "PTNameDetailViewController.h"
@interface PlanTargetViewController : UITableViewController<PTNameDetailViewControllerDelegate,UISearchDisplayDelegate>

@property(nonatomic,strong)PlanNameModel *nameModel;

@end
