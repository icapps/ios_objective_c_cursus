//
//  LabelCollectionViewCell.m
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 10/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "LabelCollectionViewCell.h"
#import "TIILabel.h"

@interface LabelCollectionViewCell ()
@property (nonatomic, weak) IBOutlet TIILabel * label;
@end

@implementation LabelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithString:(NSString *)labelText {
    self.label.text = labelText;
}

@end
