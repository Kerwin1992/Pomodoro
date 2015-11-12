//
//  TimeManager.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/6.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "TimeManager.h"
#import "TimerModel.h"
#import "StatisticModel.h"

@interface TimeManager (){
    NSUInteger remainingTime;
}

@end

@implementation TimeManager


+ (id)sharedInstance {

    static TimeManager *sharedTimerManager = nil;
    //保证此时没有其他线程对self对象进行修改，防止self对象在同一时间被其他线程访问
    @synchronized(self) {
        if (sharedTimerManager == nil) {
            sharedTimerManager = [[self alloc] init];
            
            [TimerModel setCurrentTimerState:TimerStop];
        }
    }
    return sharedTimerManager;

}


- (NSUInteger)startTimer {
    NSUInteger countDownValue;
    if([TimerModel currentTimerState] == TimerStop){
        countDownValue = [TimerModel workingTime];
        [TimerModel setCurrentTimingIntervalType:WorkingTime];//设置当前时间间隔的状态，用于更改状态显示
    }else {
        countDownValue = remainingTime;
    }
    [TimerModel setCurrentTimerState:TimerStart];
    return countDownValue;
}

- (void)pauseTimerAtValue:(NSUInteger)countDownValue {
    remainingTime = countDownValue;
    [TimerModel setCurrentTimerState:TimerPause];
    
}

- (void)stopTimer {
    remainingTime = 0;
    [TimerModel setCurrentTimerState:TimerStop];
}

- (NSUInteger)moveToTheNextIntervalType {
    
    if ([TimerModel currentTimingIntervalType] == WorkingTime) {
        //统计工作时间的个数
        [StatisticModel incrementTodaysPomodoro];
        
        if (!([StatisticModel currentPomodoro] % 4)) {
            [TimerModel setCurrentTimingIntervalType:LongPause];
            return [TimerModel longPauseTime];
        }else {
            [TimerModel setCurrentTimingIntervalType:ShortPause];
            return [TimerModel shortPauseTime];
        }
        
    }
    
    else{
        [TimerModel setCurrentTimingIntervalType:WorkingTime];
        return [TimerModel workingTime];
    }
}

- (unsigned short)PomodoroCount {
    return [StatisticModel currentPomodoro] ;
}
@end
