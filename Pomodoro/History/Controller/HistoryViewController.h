//
//  HistoryViewController.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/20.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *yesterdayStats;

@property (weak, nonatomic) IBOutlet UILabel *averageStats;

@property (weak, nonatomic) IBOutlet UILabel *maxValueStats;

@end
