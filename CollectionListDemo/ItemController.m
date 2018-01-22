//
//  ItemController.m
//  CollectionListDemo
//
//  Created by 张行舟 on 2018/1/21.
//  Copyright © 2018年 hikvision. All rights reserved.
//

#import "ItemController.h"

@implementation ItemController
- (NSInteger)numberOfItems {
    return 10;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:[UICollectionViewCell class] forSectionController:self atIndex:index];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)didUpdateToObject:(id)object {
    
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    
    return CGSizeMake(100,100);
}
@end
