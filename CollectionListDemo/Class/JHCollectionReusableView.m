//
//  JHCollectionReusableView.m
//  HiiN
//
//  Created by 张健华-迈动 on 2017/3/7.
//  Copyright © 2017年 huanli. All rights reserved.
//

#import "JHCollectionReusableView.h"
#import "JHCollectionViewLayoutAttributes.h"

@implementation JHCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[JHCollectionViewLayoutAttributes class]]) {
        JHCollectionViewLayoutAttributes *attr = (JHCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}

- (void)drawRect:(CGRect)rect {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4];
    maskLayer.path = path.CGPath;
    maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.layer.mask = maskLayer;
    
}
@end
