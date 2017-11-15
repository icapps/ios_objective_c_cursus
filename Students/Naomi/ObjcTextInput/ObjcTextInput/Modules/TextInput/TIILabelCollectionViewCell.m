//
//  LabelCollectionViewCell.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 10/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIILabelCollectionViewCell.h"

@interface TIILabelCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *reorderIcon;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation TIILabelCollectionViewCell

-(void)configureWithString:(NSString *)textValue isEditable:(BOOL) canEdit {
    self.textLabel.text = textValue;
    [self.reorderIcon setHidden:!canEdit];
}

@end
