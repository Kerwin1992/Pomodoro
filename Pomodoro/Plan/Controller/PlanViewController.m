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
#import "PlanTargetViewController.h"

#import "PlanNameModel.h"


@interface PlanViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,PlanTargetViewControllerDelegate>

@property (nonatomic,weak)UICollectionView *collectionView;



@end

@implementation PlanViewController{

    NSMutableArray *_itemArray;
    NSInteger _itemIndex;
    NSIndexPath *_indexPath;
}

#pragma mark - 存储地址
- (NSString *)dateFilePath {
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"plan.plist"];
    return path;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _itemArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[self dateFilePath]];
 
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 20.f;
    layout.minimumLineSpacing = 20.f;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10.f, 20.f, 10.f, 20.f);
    
    // Bigger items for iPad
    layout.itemSize = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? CGSizeMake(120, 120) : CGSizeMake(80, 80);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.bounces = YES;
    collectionView.alwaysBounceVertical = YES;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AddCollectionViewCell class]) bundle:nil]
     forCellWithReuseIdentifier:NSStringFromClass([AddCollectionViewCell class])];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PlanCollectionViewCell class]) bundle:nil]
     forCellWithReuseIdentifier:NSStringFromClass([PlanCollectionViewCell class])];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PlanHeaderReusableView class]) bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:NSStringFromClass([PlanHeaderReusableView class])];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handLongPress:)];
    lpgr.minimumPressDuration = 0.5;
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    
    [collectionView addGestureRecognizer:lpgr];

    // Add to view
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
}




- (void)handLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {

    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"cannot find indexpath");
    }else {
        NSArray *itemName = _itemArray;
        if (indexPath.row == itemName.count) {
            return;
        }
        UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:@"标题" message:@"弹出信息" preferredStyle:UIAlertControllerStyleActionSheet];
        [alertSheet addAction:[UIAlertAction actionWithTitle:@"重命名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"重命名" message:@"请输入" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }]];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //重命名
                UITextField *nameTextField = alertController.textFields.firstObject;
                PlanNameModel *nameModel = _itemArray[indexPath.item];
                nameModel.name = nameTextField.text;
                
                PlanCollectionViewCell *pCell = (PlanCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
                pCell.nameModel = nameModel;
                
             }];
            okAction.enabled = NO;
            [alertController addAction:okAction];
            
            
            
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                
                [textField addTarget:self action:@selector(alertTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                
            }];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }]];
        
        [alertSheet addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self deleteItemAtIndexPath:indexPath];
            
        }]];
        [alertSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        
        
        [self presentViewController:alertSheet animated:YES completion:nil];
    }
}


- (void)sendItemName:(PlanNameModel*)pName{
    
    //NSMutableArray *planNames = _itemArray;
    //itemArray中装的是PlanNameModel模型
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    [_itemArray addObject:pName];
    if(_itemArray.count == 1){
    
        [self.collectionView reloadData];
    }else{
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:_itemArray.count - 1 inSection:0]]];

    }
   
    [NSKeyedArchiver archiveRootObject:_itemArray toFile:[self dateFilePath]];
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath {

    NSMutableArray *planNames = _itemArray;
    //点击哪个删除哪个
    [planNames removeObjectAtIndex:indexPath.item];
    //在indexpath数组中删除点击的那个cell
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    [NSKeyedArchiver archiveRootObject:_itemArray toFile:[self dateFilePath]];
    
}



#pragma mark - UICollectionView Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    //return self.sectionArray.count;
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _itemArray.count + 1;
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
    NSArray *itemName = _itemArray;
    
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

#pragma mark - CollectionView代理方法

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    // Upon tapping an item, delete it. If it's the last item (the add cell), add a new one
    
    if (indexPath.item == _itemArray.count)
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
        //[self.collectionView reloadData];
        //跳入下一个页面
        PlanNameModel *nameModel = _itemArray[indexPath.item];
        _indexPath = indexPath;
        _itemIndex = indexPath.item;
        [self performSegueWithIdentifier:@"showTarget" sender:nameModel];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"showTarget"]) {
        PlanTargetViewController *controller = segue.destinationViewController;
        controller.nameModel = sender;
        controller.delegate = self;
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

#pragma mark - UICollectionViewDelegateFlowLayout

//设置header的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    // only the height component is used
    return CGSizeMake(50, 50);
}

//设置cell的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(100, 100);
}

//设置每组cell的边界，这里只有1组，所以只用设计一组
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 10;
}
//设置cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    return 15;
}



#pragma mark - PlanTargetViewControllerDelegate
- (void)refreshItemArray:(PlanNameModel *)planModel {
    [_itemArray removeObjectAtIndex:_itemIndex];
     [self.collectionView deleteItemsAtIndexPaths:@[_indexPath]];
    [_itemArray insertObject:planModel atIndex:_itemIndex];
    [self.collectionView insertItemsAtIndexPaths:@[_indexPath]];
    [self.collectionView reloadData];
    [NSKeyedArchiver archiveRootObject:_itemArray toFile:[self dateFilePath]];
    
}




@end
