//
//  TargetViewController.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/6.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NameDetailViewController.h"
#import "EditViewController.h"


@interface TargetViewController : UITableViewController<NameDetailViewControllerDelegate,EditViewControllerDelegate,UISearchDisplayDelegate>

@end
