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
    attr.transform = CGAffineTransformMakeTranslation(-200.0f,0.0f);
    return attr;
}

@end
