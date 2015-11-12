//
//  StatisticModel.m
//  Tomato
//
//  Created by 王程序 on 15/7/29.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "StatisticModel.h"
#import "Constant.h"
@implementation StatisticModel


+ (unsigned short)todaysPomodoro {
return (unsigned short)[[NSUserDefaults standardUserDefaults]
                        integerForKey:kTodaysPomodoroKey];
    
}

+ (unsigned short)currentPomodoro {
    
    return (unsigned short)[[NSUserDefaults standardUserDefaults]
                            integerForKey:kcurrentPomodoroKey];
    
}

//每运行到一次workingtime，都调用这个统计方法一次
+ (void)incrementTodaysPomodoro {
    //初始化todaysPomodoro，开始为0
    unsigned short todaysPomodoro = (unsigned short)[[NSUserDefaults standardUserDefaults]
                                                     integerForKey:kTodaysPomodoroKey];
    unsigned short currentPomodoro = (unsigned short)[[NSUserDefaults standardUserDefaults]
                                                     integerForKey:kcurrentPomodoroKey];
    todaysPomodoro++;
    currentPomodoro++;
    //将todaysPomodoro的值存入kTodaysPomodoroKey中
    [[NSUserDefaults standardUserDefaults]setInteger:todaysPomodoro forKey:kTodaysPomodoroKey];
    [[NSUserDefaults standardUserDefaults]setInteger:currentPomodoro forKey:kcurrentPomodoroKey];
    
    if (todaysPomodoro > (unsigned short)[[NSUserDefaults standardUserDefaults]
                                          integerForKey:kMaximumPomodoroKey]) {
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
   
    
}

+(void)resetcurrentPomodoro {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kcurrentPomodoroKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)resetTodaysPomodoro {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kTodaysPomodoroKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end



