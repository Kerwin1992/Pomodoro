//
//  EditViewController.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/16.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NameDetailModel.h"

@class EditViewController;
@protocol EditViewControllerDelegate <NSObject>

- (void)refreshListData:(NameDetailModel*)listData;

@end


@interface EditViewController : UIViewController

@property(nonatomic,strong)NameDetailModel *nameModel;
@property(nonatomic,weak)id<EditViewControllerDelegate>Delegate;

@end
