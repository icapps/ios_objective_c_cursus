//
//  TIITextFieldViewController.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIITextFieldViewController.h"
#import "TIIUIViewController.h"

@interface TIITextFieldViewController ()

@property (weak, nonatomic) IBOutlet UITextField * valueTextField;

@end

@implementation TIITextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.valueTextField.text = self.currentName;

    // GLobals

    NSLog(@"%p", global);
    NSLog(@"%i", globalValue);
}
- (IBAction)closeButtonPressed:(id)sender {
    if([self.valueTextField.text length] == 0) {
        self.valueTextField.layer.borderColor=[[UIColor redColor]CGColor];
        self.valueTextField.layer.borderWidth= 1.0;
    } else {
        [self.delegate editingValueFinished:self.valueTextField.text isNewName:([self.currentName length] == 0? YES : NO)];
        }
}

@end
