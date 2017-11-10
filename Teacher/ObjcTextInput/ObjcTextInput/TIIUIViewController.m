//
//  UIViewController.m
//  ObjcTextInput
//
//  Created by Stijn Willems on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"
#import "TIITextInputViewController.h"

@interface TIIUIViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = @"Ik ben gewonnen!";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[TIITextInputViewController class]]) {
        
    }
}
@end
