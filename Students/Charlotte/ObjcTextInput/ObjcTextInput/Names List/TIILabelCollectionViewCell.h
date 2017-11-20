//
//  TIILabelCollectionViewCell.h
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 10/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIILabelCollectionViewCell : UICollectionViewCell
-(void)configureWithString: (NSString *)labelText isInEditMode:(BOOL) isEditing;
-(void)toggleEditMode: (BOOL) isEditing;
@end
