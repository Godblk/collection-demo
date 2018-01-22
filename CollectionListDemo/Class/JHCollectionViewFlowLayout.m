//
//  JHCollectionViewFlowLayout.m
//  HiiN
//
//  Created by 张健华-迈动 on 2017/3/7.
//  Copyright © 2017年 huanli. All rights reserved.
//

#import "JHCollectionViewFlowLayout.h"
#import "JHCollectionReusableView.h"
#import "JHCollectionViewLayoutAttributes.h"

NSString *const JHCollectionViewSectionBackground = @"JHCollectionViewSectionBackground";

@implementation JHCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.decorationViewAttrs = [NSMutableArray array];
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self registerClass:[JHCollectionReusableView class] forDecorationViewOfKind:JHCollectionViewSectionBackground];
}

- (void)prepareLayout
{
    [super prepareLayout];
    [self.decorationViewAttrs removeAllObjects];

    NSInteger numberOfSections = [self.collectionView numberOfSections];
    id delegate = self.collectionView.delegate;
    if (!numberOfSections || ![delegate conformsToProtocol:@protocol(JHCollectionViewDelegateFlowLayout)]) {
        return;
    }
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems <= 0) {
            continue;
        }
        UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems - 1 inSection:section]];
        if (!firstItem || !lastItem) {
            continue;
        }
        
        UIEdgeInsets sectionInset = [self sectionInset];

        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            UIEdgeInsets inset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
            sectionInset = inset;
        }

        
        CGRect sectionFrame = CGRectUnion(firstItem.frame, lastItem.frame);
        sectionFrame.origin.x -= sectionInset.left/2;
        sectionFrame.origin.y -= sectionInset.top/2;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            sectionFrame.size.width += sectionInset.left/2 + sectionInset.right/2;
            sectionFrame.size.height = self.collectionView.frame.size.height;
        } else {
            sectionFrame.size.width = self.collectionView.frame.size.width-sectionInset.left/2-sectionInset.right/2;
            sectionFrame.size.height += sectionInset.top/2 + sectionInset.bottom/2;
        }
        
        // 2、定义
        JHCollectionViewLayoutAttributes *attr = [JHCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:JHCollectionViewSectionBackground withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        attr.frame = sectionFrame;
        attr.zIndex = -1;
        
        attr.backgroundColor = [delegate collectionView:self.collectionView layout:self backgroundColorForSection:section];
        [self.decorationViewAttrs addObject:attr];
    }

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
     NSMutableArray *attrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attrs addObject:attr];
        }
    }
    return attrs;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:JHCollectionViewSectionBackground]) {
        return [self.decorationViewAttrs objectAtIndex:indexPath.section];
    }
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
}
@end
