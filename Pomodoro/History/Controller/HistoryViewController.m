//
//  HistoryViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/20.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "HistoryViewController.h"
#import "StatisticModel.h"
#import "TomatoCollectionViewCell.h"

@interface HistoryViewController ()<UICollectionViewDataSource>

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.yesterdayStats.text = [NSString stringWithFormat:@"%hu",[StatisticModel yesterdayPomodoro]];
    self.maxValueStats.text = [NSString stringWithFormat:@"%hu",[StatisticModel maxPomodoro]];
    self.averageStats.text = [NSString stringWithFormat:@"%hu",[StatisticModel averagePomodoro]];
    
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TomatoCollectionViewCell *tomatoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tomatoCell" forIndexPath:indexPath];
    
    tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-contur"];
    if ([StatisticModel todaysPomodoro] > indexPath.item) {
        if (indexPath.item < 5) {
            tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-orange"];
        }else if (indexPath.item <25) {
            tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-dark-green"];
        }else {
            tomatoCell.tomatoImageView.image = [UIImage imageNamed:@"tomato-red"];
        }
    }
    return tomatoCell;
    
}




@end
