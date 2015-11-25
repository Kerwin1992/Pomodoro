//
//  SettingModel.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/21.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingModel : NSObject

@property(nonatomic,copy)NSString *pomodoroDuration;
@property(nonatomic,copy)NSString *shortBreak;
@property(nonatomic,copy)NSString *longBreak;
@property(nonatomic,copy)NSString *pomodoroPeriod;



@end
