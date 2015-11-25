//
//  PlanNameModel.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/10.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "PlanNameModel.h"

@implementation PlanNameModel


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_list forKey:@"list"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _list = [aDecoder decodeObjectForKey:@"list"];
    }
    return self;
}



@end
