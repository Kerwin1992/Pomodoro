//
//  EditViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/16.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "EditViewController.h"
#import "NameDetailViewController.h"
#import "HomeViewController.h"

#import "UIBarButtonItem+Extension.h"
#import "TargetTool.h"

#import "Constant.h"

@interface EditViewController ()<UITableViewDataSource,UITableViewDelegate,NameDetailViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,HomeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)UIPickerView *timePicker;
@property (nonatomic, strong)UIButton *doneBtn;
@property (nonatomic, strong)UIView *doneView;

@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation EditViewController{

    NSArray *_pickerData;
    NSIndexPath *_timeIndexPath;
}

#pragma mark - 底部弹出框
- (UIView *)doneView {

    if (!_doneView) {
        _doneView = [[UIView alloc]init];
        
        _doneView.backgroundColor = [UIColor colorWithRed:235.0/255 green:173.0/255 blue:216.0/255 alpha:1];
        //135,206,235,173,216,230,225,255,255
        [_doneView addSubview:self.doneBtn];
        [self.view addSubview:_doneView];
    }
    return _doneView;
}

- (UIButton *)doneBtn {
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth - 60, 0, 50, 50)];
        //_doneBtn.backgroundColor = [UIColor yellowColor];
        _doneBtn.backgroundColor = [UIColor clearColor];
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        //[_doneBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        //_doneBtn.titleLabel.textColor = [UIColor yellowColor];
        [_doneBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

- (UIPickerView *)timePicker {

    if (!_timePicker) {
        _timePicker = [[UIPickerView alloc]init];
        _timePicker.delegate = self;
        _timePicker.dataSource = self;
        _timePicker.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_timePicker];
       
    }
    return _timePicker;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *dataArray = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    _pickerData = dataArray;
    //[self ViewAnimation:self.timePicker willHidden:YES];
    self.tableView.scrollEnabled = NO;
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_timeIndexPath];
   
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
//    NameDetailModel *nameModel = [TargetTool detail];
    if ([self.Delegate respondsToSelector:@selector(refreshListData:)]) {
        
        //[self.Delegate refreshListData:self.nameModel];
        [self.Delegate refreshListData:self.nameModel];
    }


}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];//返回
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arrayM = @[@"名称",@"番茄个数",@"大计划"];
    static NSString *CellIdentifier = @"EditCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [arrayM objectAtIndex:indexPath.row];
       switch (indexPath.row) {
        case 0:{
            cell.detailTextLabel.text =self.nameModel.name;
            return cell;
        }
            break;
        case 1:{
            //_timeIndexPath = indexPath;
            if (self.nameModel.pickerTime == nil) {
                cell.detailTextLabel.text = @"4";
                return cell;
            }else{
                cell.detailTextLabel.text =self.nameModel.pickerTime;
                if ([cell.detailTextLabel.text isEqualToString:@"0"]) {
                    self.startBtn.enabled = NO;
                }else {self.startBtn.enabled = YES;}
                return cell;
            }
        }
            break;
            
        case 2:{
            if (self.nameModel.planName) {
                cell.detailTextLabel.text =self.nameModel.planName;
                return cell;
            }else {
            
                cell.detailTextLabel.text = @"空";
                return cell;
            }
            
        }
            break;
            
            
            
        default:
            break;
    }
    return nil;
    
    
    
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:{
            [self performSegueWithIdentifier:@"EditName" sender:self.nameModel];
            
        }
            break;
        case 1:{
            //点击出现timePicker
            [self ViewAnimation:self.timePicker DoneView:self.doneView willHidden:NO];
            
        }
            break;
            
        case 2:{
        }
            break;
        default:
            break;
    }
    
}

//编辑名字
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"EditName"]) {
        NameDetailViewController *controller = (NameDetailViewController *)segue.destinationViewController;
        controller.Delegate = self;
        controller.nameToEdit = sender;
    
    }else if([segue.identifier isEqualToString:@"startSegue"]){
        HomeViewController *homeController = (HomeViewController *)segue.destinationViewController;
        homeController.detailModel = sender;
        homeController.delegate = self;
    }
}

- (void)ViewAnimation:(UIView*)pickerView DoneView:(UIView*)doneView willHidden:(BOOL)hidden {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (hidden) {
                        pickerView.frame = CGRectMake(0, screenHeight, screenWidth, 162);
                        doneView.frame = CGRectMake(0, screenHeight, screenWidth, 50);
                    }else {
            
            
                        pickerView.frame = CGRectMake(0, screenHeight - 162, screenWidth, 162);
                        doneView.frame = CGRectMake(0, screenHeight - 162 - 50, screenWidth, 50);
                        
                    }

        } completion:nil];
    
}

- (void)sendEditNameDetail:(NameDetailModel *)nameDetail {

    self.nameModel = nameDetail;
    [self.tableView reloadData];

}

#pragma mark - UIPickerView
//返回列，有多少列返回多少
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//返回行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_pickerData count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_pickerData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    self.nameModel.pickerTime = [_pickerData objectAtIndex:row];
//    NameDetailModel *nameModel = [TargetTool detail];
//    nameModel.pickerTime = self.nameModel.pickerTime;
//    [TargetTool saveTarget:nameModel];
}

- (void)doneClick {
    
    
    [self.tableView reloadData];
    [self ViewAnimation:self.timePicker DoneView:self.doneView willHidden:YES];
    
    //[self PickerView:self.timePicker DoneView:self.doneView willHidden:YES];
    
}

- (IBAction)startPomodoro {
    
    [self performSegueWithIdentifier:@"startSegue" sender:self.nameModel];
}

- (void)homeViewControllerDidDisspear:(HomeViewController *)controller {
    [controller.navigationController popViewControllerAnimated:YES];
    self.nameModel.pickerTime = @"0";
    [self.tableView reloadData];
}

@end
