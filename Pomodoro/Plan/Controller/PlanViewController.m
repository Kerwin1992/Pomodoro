//
//  PlanViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/11.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "PlanViewController.h"
#import "PlanHeaderReusableView.h"
#import "PlanFooterReusableView.h"
#import "AddCollectionViewCell.h"
#import "PlanCollectionViewCell.h"
#import "PlanNameModel.h"
#import "SectionNameModel.h"

@interface PlanViewController () <PlanFooterReusableViewDelegate,PlanHeaderReusableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *sectionNames;
@property (nonatomic,assign)NSInteger sectionIndex;


- (void)sendItemName:(PlanNameModel*)pName Section:(NSInteger)section;
- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)insertSectionAtIndex:(NSUInteger)index;
- (void)deleteSectionAtIndex:(NSUInteger)index;

@end

@implementation PlanViewController{

    NSMutableArray *_listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionArray = [NSMutableArray arrayWithObjects:[NSMutableArray array], nil];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.bounces = YES;
    collectionView.alwaysBounceVertical = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AddCollectionViewCell class]) bundle:nil]
     forCellWithReuseIdentifier:NSStringFromClass([AddCollectionViewCell class])];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PlanCollectionViewCell class]) bundle:nil]
     forCellWithReuseIdentifier:NSStringFromClass([PlanCollectionViewCell class])];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PlanHeaderReusableView class]) bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:NSStringFromClass([PlanHeaderReusableView class])];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PlanFooterReusableView class]) bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
            withReuseIdentifier:NSStringFromClass([PlanFooterReusableView class])];
    
    // Add to view
    [self.view addSubview:collectionView];
}


//- (void)addNewItemInSection:(NSInteger)section {
//    PlanNameModel *pName = [PlanNameModel randomPlanName];
//    NSMutableArray *planNames = self.sectionArray[section];
//    [planNames addObject:pName];
//    //在section中插入item，item在最大数量的前一个
//    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:planNames.count - 1 inSection:section]]];
//}

- (void)sendItemName:(PlanNameModel*)pName Section:(NSInteger)section{
    
    NSMutableArray *planNames = self.sectionArray[section];
    //这里相当于往某个section中添加item
    [planNames addObject:pName];
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:planNames.count - 1 inSection:section]]];
    
}



- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath {

    NSMutableArray *planNames = self.sectionArray[indexPath.section];
    //点击哪个删除哪个
    [planNames removeObjectAtIndex:indexPath.item];
    //在indexpath数组中删除点击的那个cell
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
}


- (IBAction)planAddSectionPressed:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *nameTextField = alertController.textFields.firstObject;
        
        
        SectionNameModel *secNameModel = [[SectionNameModel alloc]init];
        secNameModel.name = nameTextField.text;
        [self.sectionNames addObject:secNameModel];
        [self insertSectionAtIndex:self.sectionIndex];
    }];
    okAction.enabled = NO;
    [alertController addAction:okAction];
    
    
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        [textField addTarget:self action:@selector(alertTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}




- (void)insertSectionAtIndex:(NSUInteger)index {

    
    
    [self.sectionArray insertObject:[NSMutableArray array] atIndex:index+1];
    
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:index+1]];
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
}

- (void)deleteSectionAtIndex:(NSUInteger)index {
    [self.sectionArray removeObjectAtIndex:index];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:index]];
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
    }];
    
}



//点击header上的删除按钮，调用代理方法，删除section
- (void)planHeaderDeleteSectionPressed:(PlanHeaderReusableView *)headerView {

    if (headerView.sectionIndex != NSNotFound) {
        [self deleteSectionAtIndex:headerView.sectionIndex];

    }
    
}
//点击footer上的添加按钮，调用代理方法，添加section
- (void)planFooterAddSectionPressed:(PlanFooterReusableView *)footerView {

//    if (footerView.sectionIndex != NSNotFound) {
//        [self insertSectionAtIndex:footerView.sectionIndex];
//    }
    //[self insertSectionAtIndex:self.sectionIndex];
}

#pragma mark - UICollectionView Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSMutableArray *itemName = self.sectionArray[section];
    return itemName.count + 1;
}
//header和foooter的复用
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PlanHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:NSStringFromClass([PlanHeaderReusableView class])
                                                                                   forIndexPath:indexPath];
        header.secNameModel = self.sectionNames[self.sectionIndex];
        header.sectionIndex = indexPath.section;
        self.sectionIndex = indexPath.section;
        header.hideDelete = collectionView.numberOfSections == 1;
        header.delegate = self;
        view = header;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
    
        PlanFooterReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([PlanFooterReusableView class]) forIndexPath:indexPath];
        //footer.sectionIndex = indexPath.section;
        footer.delegate = self;
        view = footer;
    }
    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = nil;
    NSArray *itemName = self.sectionArray[indexPath.section];
    
    if (indexPath.row == itemName.count) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AddCollectionViewCell class]) forIndexPath:indexPath];
    }else{
        PlanCollectionViewCell *pCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PlanCollectionViewCell class]) forIndexPath:indexPath];
        //pCell.planCellLabel.text = itemName[indexPath.row];
        pCell.nameModel = itemName[indexPath.item];
        cell = pCell;
    }
    return cell;
    
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    // only the height component is used
    return CGSizeMake(50, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    // only the height component is used
    return CGSizeMake(50, 50);
}

#pragma mark - CollectionView代理方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    // Upon tapping an item, delete it. If it's the last item (the add cell), add a new one
    NSArray *itemName = self.sectionArray[indexPath.section];
    
    if (indexPath.item == itemName.count)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UITextField *nameTextField = alertController.textFields.firstObject;
            PlanNameModel *nameModel = [[PlanNameModel alloc]init];
            nameModel.name = nameTextField.text;
            //将这个值传过去
            [self sendItemName:nameModel Section:indexPath.section];
            //[self addNewItemInSection:indexPath.section];
        }];
        okAction.enabled = NO;
        [alertController addAction:okAction];
        
     

        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
        [textField addTarget:self action:@selector(alertTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

        }];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        //跳入下一个页面，这里只是暂时这么写
        [self deleteItemAtIndexPath:indexPath];
    }
}


- (void)alertTextFieldDidChange:(UITextField *)textField {
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *nameTextField = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = nameTextField.text.length > 0;
        
        
    }
}



















@end
