//
//  TIILabelCollectionViewCell.m
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 10/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIILabelCollectionViewCell.h"
#import "TIILabel.h"

@interface TIILabelCollectionViewCell ()
@property (nonatomic, weak) IBOutlet TIILabel * label;
@property (nonatomic, weak) IBOutlet UIButton * reorderButton;
@end

@implementation TIILabelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithString:(NSString *)labelText {
    self.label.text = labelText;
}

- (void)configureWithString:(NSString *)labelText isInEditMode:(BOOL)isEditing {
    self.label.text = labelText;
    [self toggleEditMode:isEditing];
}

- (void)toggleEditMode:(BOOL)isEditing {
    self.reorderButton.hidden = !isEditing;
}

@end
