//
//  NameDetailModel.h
//  Pomodoro
//
//  Created by Kerwin on 15/11/7.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameDetailModel : NSObject<NSCoding>


@property (nonatomic, copy)NSString *name;
@property(nonatomic,copy)NSString *pickerTime;
@property(nonatomic,copy)NSString *planName;

@end
