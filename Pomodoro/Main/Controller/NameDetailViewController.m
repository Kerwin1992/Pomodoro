//
//  NameDetailViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/7.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "NameDetailViewController.h"
#import "NameDetailModel.h"
#import "UIBarButtonItem+Extension.h"

@interface NameDetailViewController (){
    BOOL isEdit;
}

@end

@implementation NameDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
    isEdit = NO;
    if (_nameToEdit) {
        _nameTextView.text = _nameToEdit.name;
        isEdit = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.nameTextView becomeFirstResponder];
}


- (IBAction)done:(id)sender {
    if ([_nameTextView.text isEqualToString:@""]) {
        _nameTextView.text = @"不能为空";
        
        return;
    }
    if (isEdit) {
        _nameToEdit = [self listOnSubviews];
        [_Delegate sendEditNameDetail:_nameToEdit];
    }else{
        NameDetailModel *nameDetail = [self listOnSubviews];
        [_Delegate sendAddNameDetail:nameDetail];
        
    }
    
    [self.nameTextView resignFirstResponder];
}

- (NameDetailModel *)listOnSubviews {
    NameDetailModel *nameDetail = [[NameDetailModel alloc]init];
    nameDetail.name = _nameTextView.text;
    return nameDetail;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];//返回
}


@end
