//
//  PlanTargetViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/15.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//  项目名就是标题

#import "PlanTargetViewController.h"

#import "UIBarButtonItem+Extension.h"
#import "NameDetailModel.h"


@interface PlanTargetViewController (){

    NSMutableArray *_resultlist;
     NSInteger _itemIndex;
}


@end

@implementation PlanTargetViewController



- (void)viewDidLoad {
    [super viewDidLoad];
     //self.nameModel.list = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dateFilePath]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
    
    self.title = self.nameModel.name;
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];//返回    
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    if ([self.delegate respondsToSelector:@selector(refreshItemArray:)]) {
        
        [self.delegate refreshItemArray:self.nameModel];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_resultlist count];
    }else {
        return [self.nameModel.list count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"PTarget";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NameDetailModel *nameDetail;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        nameDetail = _resultlist[indexPath.row];
    }else {
        nameDetail = self.nameModel.list[indexPath.row];
    }
    
    cell.textLabel.text = nameDetail.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //从数据模型中删除
    [self.nameModel.list removeObjectAtIndex:indexPath.row];
    
   // [NSKeyedArchiver archiveRootObject:self.nameModel.list toFile:[self dateFilePath]];
    //从表视图中删除
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NameDetailModel *nameModel;

    if (tableView == self.tableView) {
        
        nameModel = self.nameModel.list[indexPath.row];
        nameModel.planName = self.nameModel.name;
        [self performSegueWithIdentifier:@"PTEditSegue" sender:nameModel];
        _itemIndex = indexPath.row;
    }
}





- (void)sendAddNameDetail:(NameDetailModel *)nameDetail {
    
    if (!self.nameModel.list) {
        self.nameModel.list = [NSMutableArray array];
    }
    [self.nameModel.list addObject:nameDetail];
    [self.tableView reloadData];
    //[NSKeyedArchiver archiveRootObject:self.nameModel.list toFile:[self dateFilePath]];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PTAddSegue"]) {
        NameDetailViewController *controller = (NameDetailViewController *)segue.destinationViewController;
        controller.Delegate = self;
    }else if ([segue.identifier isEqualToString:@"PTEditSegue"]) {
        EditViewController *controller = (EditViewController *)segue.destinationViewController;
        controller.Delegate = self;
        controller.nameModel = sender;
    }
}

#pragma mark - search

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[c] %@",searchString];
    
    if (_resultlist) {
        [_resultlist removeAllObjects];
    }
    _resultlist = [NSMutableArray arrayWithArray:[self.nameModel.list filteredArrayUsingPredicate:predicate]];
    
    return YES;
}

- (void)refreshListData:(NameDetailModel *)listData {
    
    [self.nameModel.list removeObjectAtIndex:_itemIndex];
    [self.nameModel.list insertObject:listData atIndex:_itemIndex];
    
    [self.tableView reloadData];
    //[NSKeyedArchiver archiveRootObject:self.nameModel.list toFile:[self dateFilePath]];
}

@end
