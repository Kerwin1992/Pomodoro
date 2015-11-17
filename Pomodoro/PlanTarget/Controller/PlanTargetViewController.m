//
//  PlanTargetViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/15.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "PlanTargetViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "PNDetailModel.h"


@interface PlanTargetViewController (){
    NSMutableArray *_itemlist;
    NSMutableArray *_resultlist;
}


@end

@implementation PlanTargetViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
    
    self.title = self.nameModel.name;
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];//返回    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_resultlist count];
    }else {
        return [_itemlist count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"PTarget";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    PNDetailModel *nameDetail;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        nameDetail = _resultlist[indexPath.row];
    }else {
        nameDetail = _itemlist[indexPath.row];
    }
    
    cell.textLabel.text = nameDetail.targetName;
    return cell;
}



- (void)sendAddNameDetail:(PNDetailModel *)nameDetail {
    
    if (!_itemlist) {
        _itemlist = [NSMutableArray array];
    }
    [_itemlist addObject:nameDetail];
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PTAddSegue"]) {
        PTNameDetailViewController *controller = (PTNameDetailViewController *)segue.destinationViewController;
        controller.Delegate = self;
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



@end
