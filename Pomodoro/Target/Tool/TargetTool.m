//
//  TargetTool.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/22.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "TargetTool.h"
#import "NameDetailModel.h"

@implementation TargetTool

+(void)saveTarget:(NameDetailModel *)detail {

    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [document stringByAppendingPathComponent:@"Edit.archiver"];
    [NSKeyedArchiver archiveRootObject:detail toFile:path];
}

+ (NameDetailModel*)detail {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [document stringByAppendingPathComponent:@"Edit.archiver"];
    NameDetailModel *detail = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return detail;
    
}

@end
