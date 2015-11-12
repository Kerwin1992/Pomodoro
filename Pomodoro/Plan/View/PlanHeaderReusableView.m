//
//  PlanHeaderReusableView.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/9.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "PlanHeaderReusableView.h"
#import "SectionNameModel.h"

@interface PlanHeaderReusableView ()

- (IBAction)DeleteButtonPressed:(id)sender;



@end

@implementation PlanHeaderReusableView




- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

@end
