//
//  NameDetailModel.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/7.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "NameDetailModel.h"

@implementation NameDetailModel


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_pickerTime forKey:@"pickerTime"];
    [aCoder encodeObject:_planName forKey:@"planName"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _pickerTime = [aDecoder decodeObjectForKey:@"pickerTime"];
        _planName = [aDecoder decodeObjectForKey:@"planName"];
    }
    return self;
}

@end
