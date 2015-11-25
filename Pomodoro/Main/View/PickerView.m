//
//  PickerView.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/20.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "PickerView.h"
#import "Constant.h"

static CGFloat const Picker_Done_Height = 180.0f + 50.0f;
static CGFloat const Picker_Height = 180.f;
static CGFloat const Done_Height = 50.f;
static CGFloat const Picker_MaskAlpha = 0.2f;




@interface PickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong)UIPickerView *timePicker;
@property (nonatomic, strong)UIButton *doneBtn;
@property (nonatomic, strong)UIView *doneView;

@end

@implementation PickerView {

    UIControl *_mask;
}

- (id)initWithView:(UIView *)view {

    self = [super init];
    if (self) {
        _mask = [[UIControl alloc]initWithFrame:view.bounds];
        _mask.backgroundColor = [UIColor blackColor];
        _mask.alpha = 0.0f;
        [_mask addTarget:self action:@selector(maskTapped) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_mask];
        
        self.frame = CGRectMake(0.f,screenHeight,screenWidth,Picker_Done_Height);
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        self.alpha = 1;

        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.layer.shadowRadius = 0.5f;
        self.layer.shadowOpacity = 0.8f;
        self.layer.masksToBounds = NO;
        
        [view addSubview:self];

        UIButton *doneBtn = [[UIButton alloc]init];
        
        //创建确定View
        UIView *doneView = [[UIView alloc]init];
        [doneBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
        UIPickerView *timePicker = [[UIPickerView alloc]init];
        timePicker.delegate = self;
        timePicker.dataSource = self;
        
        [doneView addSubview:doneBtn];
        [self addSubview:doneView];
        [self addSubview:timePicker];
        self.doneBtn = doneBtn;
        self.doneView = doneView;
        self.timePicker = timePicker;
        
    }
    return self;
    
}

- (void)layoutSubviews {

    [super layoutSubviews];
    self.doneView.frame = CGRectMake(0, 0, screenWidth, Done_Height);
    self.doneBtn.frame = CGRectMake(screenWidth - 60, 0, 50, 50);
    self.timePicker.frame = CGRectMake(Done_Height, 0, screenWidth, Picker_Height);
}

- (void)openPicker {

    _isOpen = YES;
    [self.superview bringSubviewToFront:_mask];
    [self.superview bringSubviewToFront:self];
    [UIView animateWithDuration:0.36 animations:^{
        _mask.alpha = Picker_MaskAlpha;
        self.frame = CGRectMake(0, screenHeight - Picker_Done_Height, screenWidth, Picker_Done_Height);
    }];
    
}

- (void)closePciker {

    _isOpen = NO;
    [UIView animateWithDuration:0.36 animations:^{
        _mask.alpha = 0.f;
        self.frame = CGRectMake(0, screenHeight, screenWidth, Picker_Done_Height);
    }];
    
}


- (void)maskTapped {
    [self closePciker];
}

- (void)doneClick {

    
}


@end
