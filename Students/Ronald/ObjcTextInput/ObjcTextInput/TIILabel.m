//
//  TIILabel.m
//  ObjcTextInput
//
//  Created by Ronald Hollander on 14/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIILabel.h"

@interface TIILabel()
@property BOOL invert;
@end

@implementation TIILabel

-(NSString *)text {
    return super.text;
}

-(void)setText:(NSString *)text {
    self.invert = !self.invert;
    self.textColor = self.invert ? UIColor.redColor : UIColor.blackColor;
    super.text = text;
}

@end
