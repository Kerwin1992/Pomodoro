//
//  HomeViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/5.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController (){
    
    NSUInteger countDownVlaue;//剩余时间
}
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusLabel.text = @"";
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated{
   
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (IBAction)StartPomodoro {
    
    
    
}














@end
