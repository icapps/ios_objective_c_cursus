//
//  MyCustomFlowLayout.m
//  ObjcTextInput
//
//  Created by Ronald Hollander on 10/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "MyCustomFlowLayout.h"

@implementation MyCustomFlowLayout

-(void)prepareLayout {
    self.itemSize = CGSizeMake(375, 50);
}

- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    
    attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
    attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
    
    return attr;
}

@end
