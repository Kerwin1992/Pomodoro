//
//  TargetViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/6.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//  这里的项目名就是当前的待办事项

#import "TargetViewController.h"
#import "NameDetailViewController.h"
#import "EditViewController.h"

#import "NameDetailModel.h"


@interface TargetViewController (){
    
    NSMutableArray *_itemlist;//_itemlist中存储的时NameDetailModel模型
    NSMutableArray *_resultlist;
    
    NSInteger _itemIndex;
    
}

//@property (nonatomic, strong)HomeViewController *HVController;
@end

@implementation TargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"小目标";
    self.navigationItem.title = @"小目标";
    _itemlist = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dateFilePath]];

    
   
}

#pragma mark - 存储地址
- (NSString *)dateFilePath {
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"target.archiver"];
    return path;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_resultlist count];
    }else {
        return [_itemlist count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"Target";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NameDetailModel *nameDetail;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        nameDetail = _resultlist[indexPath.row];
    }else {
        nameDetail = _itemlist[indexPath.row];
    }

    cell.textLabel.text = nameDetail.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //从数据模型中删除
    [_itemlist removeObjectAtIndex:indexPath.row];

    [NSKeyedArchiver archiveRootObject:_itemlist toFile:[self dateFilePath]];
    //从表视图中删除
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NameDetailModel *nameModel;
    if (tableView == self.tableView) {
        nameModel = _itemlist[indexPath.row];
        [self performSegueWithIdentifier:@"EditSegue" sender:nameModel];
        _itemIndex = indexPath.row;
    }
    
    
}

#pragma mark - search

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[c] %@",searchString];
    
    if (_resultlist) {
        [_resultlist removeAllObjects];
    }
    _resultlist = [NSMutableArray arrayWithArray:[_itemlist filteredArrayUsingPredicate:predicate]];
    
    return YES;
}


- (void)sendAddNameDetail:(NameDetailModel *)nameDetail {

    if (!_itemlist) {
        _itemlist = [NSMutableArray array];
    }
    [_itemlist addObject:nameDetail];
    [self.tableView reloadData];

    [NSKeyedArchiver archiveRootObject:_itemlist toFile:[self dateFilePath]];
    
}

- (void)refreshListData:(NameDetailModel *)listData {

    [_itemlist removeObjectAtIndex:_itemIndex];
    [_itemlist insertObject:listData atIndex:_itemIndex];
    
    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:_itemlist toFile:[self dateFilePath]];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"AddSegue"]) {
        NameDetailViewController *controller = (NameDetailViewController *)segue.destinationViewController;
        controller.Delegate = self;
    }else if ([segue.identifier isEqualToString:@"EditSegue"]) {
        EditViewController *controller = (EditViewController *)segue.destinationViewController;
        controller.Delegate = self;
        controller.nameModel = sender;
    }
    
}

@end
