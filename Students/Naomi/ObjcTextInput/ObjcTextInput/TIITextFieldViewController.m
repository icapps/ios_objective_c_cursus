//
//  TIITextFieldViewController.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIITextFieldViewController.h"

@interface TIITextFieldViewController ()

@property (weak, nonatomic) IBOutlet UITextField * valueTextField;

@end

@implementation TIITextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)closeButtonPressed:(id)sender {
    [self.delegate editingValueFinished: self.valueTextField.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
