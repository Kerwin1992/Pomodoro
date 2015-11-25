//
//  HomeViewController.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/5.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NameDetailModel;
@class HomeViewController;

@protocol HomeViewControllerDelegate<NSObject>

- (void)homeViewControllerDidDisspear:(HomeViewController *)controller;

@end

@interface HomeViewController : UIViewController

@property(nonatomic,weak)id<HomeViewControllerDelegate>delegate;

@property (nonatomic,strong)NameDetailModel *detailModel;

@end
