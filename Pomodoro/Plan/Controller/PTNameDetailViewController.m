//
//  PTNameDetailViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/15.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "PTNameDetailViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "PNDetailModel.h"


@interface PTNameDetailViewController ()

@end

@implementation PTNameDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.NDTextView becomeFirstResponder];
}


- (IBAction)done:(id)sender {
    if ([_NDTextView.text isEqualToString:@""]) {
        _NDTextView.text = @"不能为空";
        
        return;
    }
    PNDetailModel *nameDetail = [[PNDetailModel alloc]init];
    nameDetail.targetName = _NDTextView.text;
    [_Delegate sendAddNameDetail:nameDetail];
    [self.NDTextView resignFirstResponder];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];//返回
}

@end
