//
//  LabelCollectionViewCell.m
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 10/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "LabelCollectionViewCell.h"

@interface LabelCollectionViewCell ()
@property (nonatomic, weak) IBOutlet UILabel * label;
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
