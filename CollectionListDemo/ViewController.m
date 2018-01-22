//
//  ViewController.m
//  CollectionListDemo
//
//  Created by zhangxingzhou on 2018/1/20.
//  Copyright © 2018年 hikvision. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "ItemController.h"
#import <IGListKit/IGListKit.h>
#import "JHCollectionViewFlowLayout.h"

@interface ViewController ()
<IGListAdapterDataSource, JHCollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IGListAdapter *adpter;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    JHCollectionViewFlowLayout *jhFlowLayout = [[JHCollectionViewFlowLayout alloc] init];
    jhFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    jhFlowLayout.minimumInteritemSpacing = 30;
    jhFlowLayout.minimumLineSpacing = 30;
    
    self.dataArray =@[@"asdad",@"sdfsf",@"tryy"];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:jhFlowLayout];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    self.adpter.collectionView = _collectionView;
    self.adpter.dataSource = self;
    self.adpter.collectionView.delegate = self;
}


#pragma mark - UICollectionViewDataSource
- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.dataArray;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    ItemController *controller = [[ItemController alloc] init];
    return controller;
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}
#pragma mark - JHCollectionViewDelegateFlowLayout
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section
{
    return [@[
              [UIColor redColor],
              [UIColor greenColor],
              [UIColor yellowColor]
              ] objectAtIndex:section];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

- (IGListAdapter *)adpter {
    if (!_adpter) {
        _adpter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self];
        
    }
    return _adpter;
}
@end
