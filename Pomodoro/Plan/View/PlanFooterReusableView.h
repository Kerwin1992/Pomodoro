//
//  PlanFooterReusableView.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/11.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlanFooterReusableView;

@protocol PlanFooterReusableViewDelegate<NSObject>

- (void)planFooterAddSectionPressed:(PlanFooterReusableView *)footerView;

@end

@interface PlanFooterReusableView : UICollectionReusableView

//@property(nonatomic,assign)NSUInteger sectionIndex;
@property(nonatomic,weak)id<PlanFooterReusableViewDelegate>delegate;

@end
