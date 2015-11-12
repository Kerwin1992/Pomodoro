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



//- (instancetype)initWithFrame:(CGRect)frame {
//
//    //必须调用super，用来防止父类改变对象的内存地址导致self指针指向无效内存
//    self = [super initWithFrame:frame];
//    if (self) {
//        //self.backgroundColor = [UIColor darkTextColor];
//        self.headerTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 10)];
//        self.headerTitle.backgroundColor = [UIColor whiteColor];
//        self.headerTitle.font = [UIFont fontWithName:@"Arial" size:10];
//        [self addSubview:self.headerTitle];
//    }
//    return self;
//}

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
    _sectionIndex = NSNotFound;
    self.hideDelete = YES;
}

- (void)setHideDelete:(BOOL)hideDelete
{
    _hideDelete = hideDelete;
    self.deleteBtn.hidden = hideDelete;
}

- (void)setSectionIndex:(NSUInteger)sectionIndex
{
    _sectionIndex = sectionIndex;
    //self.headerTitle.text = [NSString stringWithFormat:@"Section %ld", sectionIndex+1];
}



- (void)setSecNameModel:(SectionNameModel *)secNameModel {

    _secNameModel = secNameModel;
//    self.headerTitle.text = secNameModel.name;
}



- (IBAction)DeleteButtonPressed:(id)sender {
    [self.delegate planHeaderDeleteSectionPressed:self];
}
@end
