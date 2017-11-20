//
//  MyCustomFlowLayout.h
//  ObjcTextInput
//
//  Created by Ronald Hollander on 10/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, readonly) CGFloat horizontalInset;
@property (nonatomic, readonly) CGFloat verticalInset;

@property (nonatomic, readonly) CGFloat minimumItemWidth;
@property (nonatomic, readonly) CGFloat maximumItemWidth;
@property (nonatomic, readonly) CGFloat itemHeight;

@end
