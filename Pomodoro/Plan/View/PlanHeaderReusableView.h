//
//  PlanHeaderReusableView.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/9.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlanHeaderReusableView;
@class SectionNameModel;

@protocol PlanHeaderReusableViewDelegate <NSObject>

- (void)planHeaderDeleteSectionPressed:(PlanHeaderReusableView*)headerView;

@end

@interface PlanHeaderReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;


@end
