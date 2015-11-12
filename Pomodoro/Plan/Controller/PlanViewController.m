//
//  PlanViewController.m
//  Pomodoro
//
//  Created by Kerwin on 15/11/11.
//  Copyright (c) 2015年 Kerwin. All rights reserved.
//

#import "PlanViewController.h"
#import "PlanHeaderReusableView.h"

#import "AddCollectionViewCell.h"
#import "PlanCollectionViewCell.h"
#import "PlanNameModel.h"
#import "SectionNameModel.h"

@interface PlanViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *itemArray;

//@property (nonatomic,assign)NSInteger sectionIndex;


@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemArray = [NSMutableArray array];
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

    
    // Add to view
    [self.view addSubview:collectionView];
}


- (void)sendItemName:(PlanNameModel*)pName{
    
    //NSMutableArray *planNames = self.itemArray;
    
    [self.itemArray addObject:pName];
    if(self.itemArray.count == 1){
    
        [self.collectionView reloadData];
    }else{
    
//        [self.collectionView performBatchUpdates:^{
//            NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
//            for (NSUInteger i = [self.collectionView numberOfItemsInSection:0]; i < self.itemArray.count ; i++)
//            {
//                [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
//            }
//            
//            [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
//        } completion:nil];
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.itemArray.count - 1 inSection:0]]];
        
    }
    
}



- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath {

    NSMutableArray *planNames = self.itemArray;
    //点击哪个删除哪个
    [planNames removeObjectAtIndex:indexPath.item];
    //在indexpath数组中删除点击的那个cell
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
}



#pragma mark - UICollectionView Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    //return self.sectionArray.count;
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.itemArray.count + 1;
}
//header和foooter的复用
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PlanHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:NSStringFromClass([PlanHeaderReusableView class])
                                                                                   forIndexPath:indexPath];
        view = header;
    }
    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = nil;
    NSArray *itemName = self.itemArray;
    
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

#pragma mark - CollectionView代理方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    // Upon tapping an item, delete it. If it's the last item (the add cell), add a new one
    NSArray *itemName = self.itemArray;
    
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
            [self sendItemName:nameModel];
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
