//
//  HomeViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/5.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "HomeViewController.h"
#import "TimeManager.h"
#import "TimerModel.h"
#import "StatisticModel.h"
#import "NameDetailModel.h"

@interface HomeViewController ()
{
    
    NSUInteger countDownValue;//剩余时间
}
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic) NSTimer *generalTimer;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.startBtn.userInteractionEnabled = YES;
    self.stopBtn.userInteractionEnabled = NO;
    self.pauseBtn.userInteractionEnabled = NO;
    
    [self setupAnimarions];
    self.startBtn.alpha = 1;
    self.stopBtn.alpha = 0.3;
    self.pauseBtn.alpha = 0.3;
    self.statusLabel.text = @"";
    if (self.detailModel.name) {
        self.titleLabel.text = self.detailModel.name;
    }else {
    
        self.titleLabel.text = @"开始第一个番茄";
    }
    [UIView commitAnimations];
    [TimerModel setCurrentTimerState:TimerStop];
    [TimerModel setCurrentTimingIntervalType:WorkingTime];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [StatisticModel resetcurrentPomodoro];
}

-(void)viewWillDisappear:(BOOL)animated{
   
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
}

- (IBAction)StartPomodoro {
    countDownValue = [[TimeManager sharedInstance]startTimer];
    [self updateUI];
    _generalTimer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self
                                                   selector:@selector(timerTicked)
                                                   userInfo:nil
                                                    repeats:YES];
    
}

- (IBAction)StopPomodoro {
    [_generalTimer invalidate];
    _generalTimer = nil;
    [[TimeManager sharedInstance] stopTimer];
     [self updateUI];
}


- (IBAction)PausePomodoro {
    [_generalTimer invalidate];
    _generalTimer = nil;//停止后，要将timer赋值为空
    [[TimeManager sharedInstance]pauseTimerAtValue:countDownValue];
    [self updateUI];

}

- (IBAction)SwitchBtn {
    [self PausePomodoro];
}


- (void)timerTicked {
    if (countDownValue == 0) {
        //如果剩余时间为0，则跳转到下一个时间间隔中，即剩余时间为下一个模式的时间长度
        countDownValue = [[TimeManager sharedInstance]moveToTheNextIntervalType];
        //每次跳转都要更新label状态栏
        [self updateStatusLabel];
        if ([[TimeManager sharedInstance]PomodoroCount] == [self.detailModel.pickerTime intValue]) {
            [_generalTimer invalidate];
            _generalTimer = nil;
            //[self.navigationController popViewControllerAnimated:YES];
            [self.delegate homeViewControllerDidDisspear:self];
            
        }
    }
    countDownValue--;
    //时间栏显示
    self.timeLabel.text = [TimerModel stringTimeFormatForValue:countDownValue];
}

- (void)updateUI {
    switch ([TimerModel currentTimerState]) {
        case TimerStart:
            
            [self updateStatusLabel];
            
            self.startBtn.userInteractionEnabled = NO;
            self.stopBtn.userInteractionEnabled = YES;
            self.pauseBtn.userInteractionEnabled = YES;
            
            [self setupAnimarions];
            self.startBtn.alpha = 0.3;
            self.stopBtn.alpha = 1;
            self.pauseBtn.alpha = 1;
            self.statusLabel.alpha = 1;
            
            [UIView commitAnimations];

            break;
            
        case TimerPause:
            self.startBtn.userInteractionEnabled = YES;
            self.stopBtn.userInteractionEnabled = YES;
            self.pauseBtn.userInteractionEnabled = NO;
            
            [self setupAnimarions];
            
            self.startBtn.alpha = 1;
            self.stopBtn.alpha = 1;
            self.pauseBtn.alpha = 0.3;
            self.statusLabel.alpha = 0.6;
            
            [UIView commitAnimations];

            
            break;
            
        case TimerStop:
            
            self.startBtn.userInteractionEnabled = YES;
            self.stopBtn.userInteractionEnabled = NO;
            self.pauseBtn.userInteractionEnabled = NO;
            
            [self setupAnimarions];
            
            self.startBtn.alpha = 1;
            self.stopBtn.alpha = 0.3;
            self.pauseBtn.alpha = 0.3;
            self.statusLabel.alpha = 0;
            
            [UIView commitAnimations];
            
            // reset the display
            self.timeLabel.text = [TimerModel stringTimeFormatForValue:[TimerModel workingTime]];
            
            break;

            
        default:
            break;
    }
}
-(void)updateStatusLabel {
    
    switch ([TimerModel currentTimingIntervalType]) {
        case WorkingTime:
            self.statusLabel.text = @"Working Time";
            break;
        case ShortPause:
            self.statusLabel.text = @"Short Break Time";
            break;
        case LongPause:
            self.statusLabel.text = @"Long Break Time";
            break;
        default:
            self.statusLabel.text = @"";
            break;
    }
}

- (void)setupAnimarions {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
}






@end
