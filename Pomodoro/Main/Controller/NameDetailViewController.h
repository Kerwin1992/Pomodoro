//
//  NameDetailViewController.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/7.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NameDetailModel;

@protocol NameDetailViewControllerDelegate <NSObject>

@optional
- (void)sendAddNameDetail:(NameDetailModel *)nameDetail;
- (void)sendEditNameDetail:(NameDetailModel *)nameDetail;

@end

@interface NameDetailViewController : UIViewController

@property(nonatomic,weak)id<NameDetailViewControllerDelegate>Delegate;

@property (weak, nonatomic) IBOutlet UITextView *nameTextView;
@property (nonatomic, strong)NameDetailModel *nameToEdit;

@end
