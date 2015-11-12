//
//  TimeManager.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/6.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeManager : NSObject

+ (id)sharedInstance;
/**
 开始时剩余时间
 */
- (NSUInteger)startTimer;
/**
 暂停时剩余时间
 */
- (void)pauseTimerAtValue:(NSUInteger)countDownValue;
/**
 停止时剩余时间
 */
- (void)stopTimer;
/**
 判断下一个时间段状态并返回下一个时间段时间
 */
- (NSUInteger)moveToTheNextIntervalType;
/**
 统计番茄个数
 */
- (unsigned short)PomodoroCount;
@end
