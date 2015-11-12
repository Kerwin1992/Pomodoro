//
//  PlanFooterReusableView.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/11.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "PlanFooterReusableView.h"

@interface PlanFooterReusableView ()

- (IBAction)AddSectionPressed:(id)sender;


@end


@implementation PlanFooterReusableView


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        //_sectionIndex = NSNotFound;
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    //_sectionIndex = NSNotFound;
}
- (IBAction)AddSectionPressed:(id)sender {
    
    [self.delegate planFooterAddSectionPressed:self];
    
}


@end
