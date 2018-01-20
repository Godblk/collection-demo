//
//  CSCCardFlowLayout.m
//  CollectionListDemo
//
//  Created by zhangxingzhou on 2018/1/20.
//  Copyright © 2018年 hikvision. All rights reserved.
//

#import "CSCCardFlowLayout.h"
#import "CSCCardDecorationReusableView.h"

@interface CSCCardFlowLayout()
@property (nonatomic ,strong) NSMutableArray *decorationViewAttrs;

@end

@implementation CSCCardFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.decorationViewAttrs = [NSMutableArray array];
        [self registerClass:[CSCCardDecorationReusableView class] forDecorationViewOfKind:@"SectionBackground"];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    NSInteger  numberOfSections = self.collectionView.numberOfSections;
    [self.decorationViewAttrs removeAllObjects];
    for (int i = 0;i<numberOfSections;i++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:i];
        if (numberOfItems > 0) {
            UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
            UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems - 1 inSection:i]];
            UIEdgeInsets sectionInset = [self sectionInset];
            
            if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
                sectionInset =
            }
        }else {
            continue;
        }
        
        
        var sectionInset = self.sectionInset
        if let inset = delegate.collectionView?(self.collectionView!, layout: self, insetForSectionAt: section) {
            sectionInset = inset
        }
        
        var sectionFrame = firstItem.frame.union(lastItem.frame)
        sectionFrame.origin.x = 0
        sectionFrame.origin.y -= sectionInset.top
        
        if self.scrollDirection == .horizontal {
            sectionFrame.size.width += sectionInset.left + sectionInset.right
            sectionFrame.size.height = self.collectionView!.frame.height
        } else {
            sectionFrame.size.width = self.collectionView!.frame.width
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom
        }
        
        // 2、定义视图属性
        let attr = FLFoodCategoryCollectionViewLayoutAttributes(forDecorationViewOfKind: "SectionBackground", with: IndexPath(item: 0, section: section))
        attr.frame = sectionFrame
        attr.zIndex = -1
        attr.backgroundColor = delegate.collectionView(self.collectionView!, layout: self, backgroundColorForSectionAt: section)
        self.decorationViewAttrs.append(attr)
    }
}
@end
