//
//  PTNameDetailViewController.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/15.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PNDetailModel;

@protocol PTNameDetailViewControllerDelegate <NSObject>

@optional
- (void)sendAddNameDetail:(PNDetailModel *)nameDetail;

@end



@interface PTNameDetailViewController : UIViewController

@property(nonatomic,weak)id<PTNameDetailViewControllerDelegate>Delegate;
@property (weak, nonatomic) IBOutlet UITextView *NDTextView;

@end
