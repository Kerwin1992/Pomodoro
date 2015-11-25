//
//  MoreViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/20.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "MoreViewController.h"
#import "Constant.h"
#import "SettingModel.h"

static CGFloat const Picker_Done_Height = 180.0f + 50.0f;
static CGFloat const Picker_Height = 180.f;
static CGFloat const Done_Height = 50.f;
static CGFloat const Picker_MaskAlpha = 0.2f;

@interface MoreViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong)UIPickerView *timePicker;
@property (nonatomic, strong)UIButton *doneBtn;
@property (nonatomic, strong)UIView *doneView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)SettingModel *setModel;

@end

@implementation MoreViewController{

    UIControl *_mask;
    NSArray *_timeArray;
    NSArray *_soundArray;
    NSArray *_otherArray;
    NSMutableArray *_dataArray;
    NSArray *_pomodoroDuration;
    NSArray *_shortBreakArray;
    NSArray *_longBreakArray;
    NSArray *_pomodoroPeriod;
    NSMutableArray *_timeDataArray;
    NSIndexPath *_indexPath;
    
}

- (SettingModel *)setModel {
    if (!_setModel) {
        self.setModel = [[SettingModel alloc]init];
    }
    return _setModel;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0.f,screenHeight,screenWidth,Picker_Done_Height)];
        
        contentView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        contentView.alpha = 1;
        
        contentView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        contentView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        contentView.layer.shadowRadius = 0.5f;
        contentView.layer.shadowOpacity = 0.8f;
        contentView.layer.masksToBounds = NO;
        [contentView addSubview:self.doneView];
        [contentView addSubview:self.timePicker];
        [self.view addSubview:contentView];
       
        self.contentView = contentView;
    }
    return _contentView;
    
}


- (UIView *)doneView {
    
    if (!_doneView) {
        UIView *doneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, Done_Height)];
        
        doneView.backgroundColor = [UIColor colorWithRed:235.0/255 green:173.0/255 blue:216.0/255 alpha:1];
        //135,206,235,173,216,230,225,255,255
        [doneView addSubview:self.doneBtn];
        self.doneView = doneView;
    }
    return _doneView;
}

- (UIButton *)doneBtn {
    if (!_doneBtn) {
        UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth - 60, 0, 50, 50)];
        //_doneBtn.backgroundColor = [UIColor yellowColor];
        doneBtn.backgroundColor = [UIColor clearColor];
        [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        //[_doneBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        //_doneBtn.titleLabel.textColor = [UIColor yellowColor];
        [doneBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
        self.doneBtn = doneBtn;
    }
    return _doneBtn;
}

- (UIPickerView *)timePicker {
    
    if (!_timePicker) {
        UIPickerView *timePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, Done_Height, screenWidth, Picker_Height)];
        timePicker.backgroundColor = [UIColor whiteColor];
        timePicker.delegate = self;
        timePicker.dataSource = self;
        self.timePicker = timePicker;
        
    }
    return _timePicker;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mask = [[UIControl alloc]initWithFrame:self.view.bounds];
    _mask.backgroundColor = [UIColor blackColor];
    _mask.alpha = 0.0f;
    [_mask addTarget:self action:@selector(maskTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mask];

    _isOpen = NO;
    self.title = @"设置";
    _timeArray = [[NSArray alloc]initWithObjects:@"工作时间",@"短暂停时间",@"长暂停时间",@"周期",nil];
    _soundArray = [[NSArray alloc]initWithObjects:@"工作结束提醒",@"休息结束提醒",@"工作声音",@"振动提醒", nil];
    _otherArray = [[NSArray alloc]initWithObjects:@"版本信息",@"意见反馈",@"评价", nil];
    _dataArray = [[NSMutableArray alloc]initWithObjects:_timeArray,_soundArray,_otherArray, nil];
    
    _pomodoroDuration = [[NSArray alloc]initWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60", nil];
    _shortBreakArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    _longBreakArray = [[NSArray alloc]initWithObjects:@"5",@"10",@"15",@"20",@"25",@"30", nil];
    _pomodoroPeriod = [[NSArray alloc]initWithObjects:@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    _timeDataArray =  [[NSMutableArray alloc]initWithObjects:_pomodoroDuration,_shortBreakArray,_longBreakArray,_pomodoroPeriod, nil];
    
    NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
    self.setModel.pomodoroDuration = [userDefult objectForKey:kWorkingTimeKey];
    self.setModel.shortBreak = [userDefult objectForKey:kShortPauseTimeKey];
    self.setModel.longBreak = [userDefult objectForKey:kLongPauseTimeKey];
    
}

- (void)indexPathPress{

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return [[_dataArray objectAtIndex:section] count];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"setCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //[cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    
    NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
    cell.textLabel.text = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                if (self.setModel.pomodoroDuration) {
                    [userDefult setObject:self.setModel.pomodoroDuration forKey:kWorkingTimeKey];
                
                    cell.detailTextLabel.text = self.setModel.pomodoroDuration;
                    
                }else{
                    cell.detailTextLabel.text = @"25";
                }
                return cell;
                
            }break;
            case 1:{
                if (self.setModel.shortBreak) {
                    [userDefult setObject:self.setModel.shortBreak forKey:kShortPauseTimeKey];
                    cell.detailTextLabel.text = self.setModel.shortBreak;
                    
                }else{
                    cell.detailTextLabel.text = @"5";
                }
                return cell;
                
            }break;
            case 2:{
                if (self.setModel.longBreak) {
                    [userDefult setObject:self.setModel.longBreak forKey:kLongPauseTimeKey];
                    cell.detailTextLabel.text = self.setModel.longBreak;
                    
                }else{
                    cell.detailTextLabel.text = @"15";
                }
                return cell;
                
            }break;
            case 3:{
                if (self.setModel.pomodoroPeriod) {
                    cell.detailTextLabel.text = self.setModel.pomodoroPeriod;
                    
                }else{
                    cell.detailTextLabel.text = @"4";
                }
                return cell;
                
            }break;
   
            default:
                break;
        }
    }
    
    return cell;
}
#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    
    
    if (indexPath.section == 0) {
        if (_isOpen) {
            [self closePciker];
        }else {
            [self openPicker];
        }
    }
}

#pragma mark - UIPickerView
//返回列，有多少列返回多少
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
//返回行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_indexPath.section == 0)
        return [[_timeDataArray objectAtIndex:_indexPath.row] count];
    else return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (_indexPath.section == 0) {
        return [[_timeDataArray objectAtIndex:_indexPath.row]objectAtIndex:row];
    }else return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
    if (_indexPath.section == 0) {
        switch (_indexPath.row) {
            case 0:
                self.setModel.pomodoroDuration = [_pomodoroDuration objectAtIndex:row];
                break;
            case 1:
                self.setModel.shortBreak = [_shortBreakArray objectAtIndex:row];
                break;
            case 2:
                self.setModel.longBreak = [_longBreakArray objectAtIndex:row];
                break;
            case 3:
                self.setModel.pomodoroPeriod = [_pomodoroPeriod objectAtIndex:row];
                break;

            default:
                break;
        }
        
        
    }
    
    
}

- (void)openPicker {
    [self.timePicker reloadAllComponents];
    _isOpen = YES;
    self.tableView.scrollEnabled = NO;
    [self.view bringSubviewToFront:_mask];
    [self.view bringSubviewToFront:self.contentView];
    [UIView animateWithDuration:0.36 animations:^{
        _mask.alpha = Picker_MaskAlpha;
        self.contentView.frame = CGRectMake(0, screenHeight - Picker_Done_Height, screenWidth, Picker_Done_Height);
    }];
    
}

- (void)closePciker {
    
    _isOpen = NO;
    [UIView animateWithDuration:0.36 animations:^{
        _mask.alpha = 0.f;
        self.contentView.frame = CGRectMake(0, screenHeight, screenWidth, Picker_Done_Height);
    }];
    
}


- (void)doneClick {
    
    
    [self.tableView reloadData];
    [self closePciker];
    
}

- (void)maskTapped {

    [self closePciker];
}

@end
