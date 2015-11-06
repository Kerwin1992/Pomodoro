//
//  RootViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/5.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "RootViewController.h"
#import "LeftMenuViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib {
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;


    self.scaleMenuView = NO;
    self.scaleContentView = NO;

    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftMenuViewController"];
    self.backgroundImage = [UIImage imageNamed:@"darkgreen"];
    self.delegate = self;
}


@end
