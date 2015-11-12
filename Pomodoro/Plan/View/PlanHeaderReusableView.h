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
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic,strong)SectionNameModel *secNameModel;
@property (nonatomic,assign)NSUInteger sectionIndex;
@property (nonatomic,assign)BOOL hideDelete;

@property (nonatomic,weak)id<PlanHeaderReusableViewDelegate>delegate;


@end
