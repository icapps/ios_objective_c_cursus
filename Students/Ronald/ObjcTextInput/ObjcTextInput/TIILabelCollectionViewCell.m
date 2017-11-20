//
//  LabelCollectionViewCell.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 10/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIILabelCollectionViewCell.h"

@interface TIILabelCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dragHandlerImage;

@end
@implementation TIILabelCollectionViewCell

-(void)configureWithString:(NSString *)textValue andDragHandler:(BOOL)isEditable {
    self.textLabel.text = textValue;
    [self.dragHandlerImage setHidden:!isEditable];
}



@end
