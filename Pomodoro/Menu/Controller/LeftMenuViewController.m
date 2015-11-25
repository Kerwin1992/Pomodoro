//
//  LeftMenuViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/5.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "HomeViewController.h"
#import "TargetViewController.h"
#import "UIViewController+RESideMenu.h"
#import "LeftMenuTableViewCell.h"


@interface LeftMenuViewController ()
@property (strong,readwrite,nonatomic)UITableView *tableView;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"TargetViewController"]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"PlanViewController"]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HistoryViewController"]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MoreViewController"]]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    LeftMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LeftMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.selectedBackgroundView = [[UIView alloc] init];
    }

    NSArray *titles = @[@"番茄", @"小目标", @"大计划", @"历史", @"设置"];
    NSArray *images = @[@"tomato-contur",@"Gavel",@"CFR",@"Building",@"Settings"];
    cell.menuLabel.text = titles[indexPath.row];
    cell.menuLabel.font = [UIFont fontWithName:@"DFPOP1W5" size:20];
    cell.menuImageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.backgroundColor = [UIColor colorWithRed:220.0/255 green:255.0/255 blue:255.0/255 alpha:1];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
}



@end
