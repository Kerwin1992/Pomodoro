//
//  TimerModel.h
//  Tomato
//
//  Created by 王程序 on 15/7/28.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerModel : NSObject

typedef enum{
    TimerStart ,
    TimerPause  ,
    TimerStop  ,
}TimerState;

typedef enum {
    WorkingTime ,
    ShortPause  ,
    LongPause ,
}IntervalType;

+(TimerState)currentTimerState;
+(void)setCurrentTimerState:(TimerState)newState;
+(IntervalType)currentTimingIntervalType;
+(void)setCurrentTimingIntervalType:(IntervalType)newType;

+(NSUInteger)workingTime;
+(NSUInteger)shortPauseTime;
+(NSUInteger)longPauseTime;
+(NSString *)stringTimeFormatForValue:(unsigned long)countDownValue;

@end
