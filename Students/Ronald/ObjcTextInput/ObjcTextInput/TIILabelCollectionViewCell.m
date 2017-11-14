//
//  LabelCollectionViewCell.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 10/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIILabelCollectionViewCell.h"
#import "TIILabel.h"

@interface TIILabelCollectionViewCell ()
    @property (weak, nonatomic) IBOutlet TIILabel *textLabel;
@end

@implementation TIILabelCollectionViewCell

-(void)awakeFromNib {
    [super awakeFromNib];
}

-(void)configureCell: (NSString *) text {
    self.textLabel.text = text;
}

@end
