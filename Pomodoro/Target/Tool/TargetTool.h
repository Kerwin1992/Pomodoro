//
//  TargetTool.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/22.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NameDetailModel;

@interface TargetTool : NSObject

+(void)saveTarget:(NameDetailModel*)detail;
+(NameDetailModel*)detail;

@end
