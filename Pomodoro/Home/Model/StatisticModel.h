//
//  StatisticModel.h
//  Tomato
//
//  Created by 王程序 on 15/7/29.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticModel : NSObject
/**
 今天的总番茄数
 */
+ (unsigned short)todaysPomodoro;
/**
 当前的番茄数
 */
+ (unsigned short)currentPomodoro;
/**
 番茄个数统计方法
 */
+ (void)incrementTodaysPomodoro;
/**
 重置
 */
+ (void)resetcurrentPomodoro;

+(unsigned short)averagePomodoro;

+(unsigned short)maxPomodoro;

+(unsigned short)yesterdayPomodoro;

+(void)changeDayIfNeede;

+(void)setTodayPomodoro:(unsigned short)newPomodoValue;



@end
