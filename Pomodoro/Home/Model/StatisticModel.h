//
//  StatisticModel.h
//  Tomato
//
//  Created by 王程序 on 15/7/29.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticModel : NSObject
+ (unsigned short)todaysPomodoro;
+ (unsigned short)currentPomodoro;
+ (void)incrementTodaysPomodoro;
+ (void)resetcurrentPomodoro;
@end
