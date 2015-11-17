//
//  EditViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/16.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "EditViewController.h"
#import "NameDetailViewController.h"


@interface EditViewController ()<UITableViewDataSource,UITableViewDelegate,NameDetailViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EditViewController

//- (void)setNameModel:(NameDetailModel *)nameModel {
//    _nameModel = nameModel;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    switch (indexPath.row) {
        case 0:{
            
            
            cell.textLabel.text = arrayM[indexPath.row];
            
            cell.detailTextLabel.text = self.nameModel.name;
            return cell;
            
            
        }
            break;
        case 1:{
            
            cell.textLabel.text = arrayM[indexPath.row];
            
            cell.detailTextLabel.text = self.nameModel.name;
            return cell;
            
            
        }
            break;
            
        case 2:{
            cell.textLabel.text = arrayM[indexPath.row];
            
            cell.detailTextLabel.text = self.nameModel.name;
            return cell;
            
            
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
            
            
        }
            break;
            
        case 2:{
            
            
        }
            break;
            
            
            
        default:
            break;
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"EditName"]) {
        NameDetailViewController *controller = (NameDetailViewController *)segue.destinationViewController;
        controller.Delegate = self;
        controller.nameToEdit = sender;
    
    }
}

- (void)sendEditNameDetail:(NameDetailModel *)nameDetail {

    self.nameModel = nameDetail;
    [self.tableView reloadData];
    if ([self.Delegate respondsToSelector:@selector(refreshListData:)]) {
        [self.Delegate refreshListData:self.nameModel];
    }
    
}

@end
