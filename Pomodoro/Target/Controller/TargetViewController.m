//
//  TargetViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/6.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "TargetViewController.h"
#import "NameDetailViewController.h"
#import "NameDetailModel.h"

@interface TargetViewController (){
    NSMutableArray *_itemlist;
    NSMutableArray *_resultlist;
}

@end

@implementation TargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_resultlist count];
    }else {
        return [_itemlist count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"Checklist";
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

- (void)sendAddNameDetail:(NameDetailModel *)nameDetail {

    if (!_itemlist) {
        _itemlist = [NSMutableArray array];
    }
    [_itemlist addObject:nameDetail];
    [self.tableView reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"AddSegue"]) {
        NameDetailViewController *controller = (NameDetailViewController *)segue.destinationViewController;
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
