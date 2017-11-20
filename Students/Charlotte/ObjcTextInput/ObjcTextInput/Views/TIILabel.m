//
//  TIILabel.m
//  ObjcTextInput
//
//  Created by Stijn Willems on 14/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIILabel.h"

@interface TIILabel ()
@property BOOL invert;
@property (nonatomic, strong) UIColor* colorTwo;

@end
@implementation TIILabel
@synthesize colorOne = _colorOne;

-(UIColor *)colorTwo {
    if (_colorTwo == nil) {
        _colorTwo = UIColor.blackColor;
    }
    return _colorTwo;
}

-(UIColor *)colorOne {
    if (_colorOne == nil) {
        _colorOne = UIColor.brownColor;
    }
    return _colorOne;
}

-(void)setColorOne:(UIColor *)colorOne {
    _colorOne = colorOne;
    _colorTwo = UIColor.blueColor;
}

-(NSString *)text {
    return super.text;
}

-(void)setText:(NSString *)text {
    self.invert = !self.invert;
    self.textColor = self.invert ? self.colorOne : UIColor.blackColor;
    super.text = text;
}

@end
