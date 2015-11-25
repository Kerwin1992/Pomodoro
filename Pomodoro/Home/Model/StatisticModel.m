//
//  StatisticModel.m
//  Tomato
//
//  Created by 王程序 on 15/7/29.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "StatisticModel.h"
#import "Constant.h"
#import "NSDate+Yesterday.h"

@implementation StatisticModel

static unsigned short lastDaysAvg;







+ (unsigned short)todaysPomodoro {
return (unsigned short)[[NSUserDefaults standardUserDefaults]
                        integerForKey:kTodaysPomodoroKey];
    
}

+ (unsigned short)currentPomodoro {
    
    return (unsigned short)[[NSUserDefaults standardUserDefaults]
                            integerForKey:kcurrentPomodoroKey];
    
}

//每运行到一次workingtime，都调用这个统计方法一次
//todaysPomodoro是今天有多少个番茄钟
//currentPomodoro是当前统计的番茄钟，可以在开始新事件时清零
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
        [[NSUserDefaults standardUserDefaults] setInteger:todaysPomodoro forKey:kMaximumPomodoroKey];
        
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(void)resetcurrentPomodoro {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kcurrentPomodoroKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)resetTodaysPomodoro {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kTodaysPomodoroKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (unsigned short)averagePomodoro {
    NSArray *last7DaysValues = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults]objectForKey:kLastDaysKey]];
    NSInteger numberOfWorkedDays = 0;
    NSInteger sum = 0;
    
    if (last7DaysValues) {
        for (NSNumber *dayValue in last7DaysValues) {
            numberOfWorkedDays++;
            sum += dayValue.shortValue;
        }
        return lastDaysAvg = sum / numberOfWorkedDays;
    }else {
        return 0;
    }
    
}

+ (unsigned short)maxPomodoro {
    return (unsigned short)[[NSUserDefaults standardUserDefaults]integerForKey:kMaximumPomodoroKey];
}

+ (unsigned short)yesterdayPomodoro {
    return (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kYesterdayPomodoroKey];
}

+ (void)changeDayIfNeede {
    
    NSDate *date = [[NSUserDefaults standardUserDefaults]objectForKey:kLastOpeningTimestampKey];//获取上次打开软件的时间
    
    unsigned short todaysPomodoro = (unsigned short)[[NSUserDefaults standardUserDefaults] integerForKey:kTodaysPomodoroKey];
    
    if ([date isYesterday]) {
        NSLog(@" the day changed");
        
        // set yesterday value
        [[NSUserDefaults standardUserDefaults] setInteger:todaysPomodoro forKey:kYesterdayPomodoroKey];
        
        // get the avg array
        NSArray *last7DaysValues = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kLastDaysKey]];
        
        if (last7DaysValues) {
            NSMutableArray *localArray = [[NSMutableArray alloc] initWithArray:last7DaysValues];
            [localArray addObject:[NSNumber numberWithUnsignedShort:todaysPomodoro]];
            last7DaysValues = [localArray copy];
        } else {
            last7DaysValues = @[[NSNumber numberWithUnsignedShort:todaysPomodoro]];
        }
        
        // save the array
        [[NSUserDefaults standardUserDefaults] setObject: [NSKeyedArchiver archivedDataWithRootObject:last7DaysValues] forKey:kLastDaysKey];
        
        // reset today counter
        [self resetTodaysPomodoro];
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSDate date] forKey:kLastOpeningTimestampKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



@end



