//
//  TimerModel.m
//  Tomato
//
//  Created by 王程序 on 15/7/28.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "TimerModel.h"
#import "Constant.h"

@implementation TimerModel

static TimerState currentState = TimerStop;
static IntervalType intervalType;

+(TimerState)currentTimerState{
    return currentState;
}

+(void)setCurrentTimerState:(TimerState)newState{
    currentState = newState;
}

+(IntervalType)currentTimingIntervalType{
    return intervalType;
}

+(void)setCurrentTimingIntervalType:(IntervalType)newType{
    intervalType = newType;
}
//工作时间
+(NSUInteger)workingTime {
NSUInteger value = (NSUInteger)[[NSUserDefaults standardUserDefaults]
                                        integerForKey:kWorkingTimeKey];
    if (value == 0) {
        //1500 ＝ 25min
        return 1500;
    }
    else {
        return value*60;
    }
}
//短休息时间
+(NSUInteger)shortPauseTime {
NSUInteger value = (NSUInteger)[[NSUserDefaults standardUserDefaults]
                                        integerForKey:kShortPauseTimeKey];
        if (value == 0) {
        //300 ＝ 5min
            return 300;
        }
        else {
            return value*60;
        }

}
//长休息时间
+(NSUInteger)longPauseTime {
NSUInteger value = (NSUInteger)[[NSUserDefaults standardUserDefaults]
                                        integerForKey:kLongPauseTimeKey];
    
    if (value == 0) {
        //900 ＝ 15min
        return 900;
    }
    else {
        return value*60;
    }

}

+(NSString *)stringTimeFormatForValue:(unsigned long)countDownValue{

    div_t divResult;
    //quot商，rem余数
    divResult = div(countDownValue, 60);
    //如果大于了60分钟
    if (divResult.quot > 59) {
        
        div_t secondResult = div(divResult.quot, 60);
        return [NSString stringWithFormat:@"%d:%02d:%02d",
                secondResult.quot,secondResult.rem,divResult.rem];
        
    }else {
        
        return [NSString stringWithFormat:@"%02d:%02d",divResult.quot,divResult.rem];
    }
    
  
}
@end
