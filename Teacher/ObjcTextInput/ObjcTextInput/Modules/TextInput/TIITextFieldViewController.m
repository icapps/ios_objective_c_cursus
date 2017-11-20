//
//  TIITextFieldViewController.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIITextFieldViewController.h"
#import "TIIUIViewController.h"
#import "ObjcTextInput-Swift.h"

@interface TIITextFieldViewController () <UIGestureRecognizerDelegate>

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
        [self.editingDelegate editingValueFinished:self.valueTextField.text isNewName:([self.currentName length] == 0? YES : NO)];
        }
}

- (void) itsTimeToDismiss {
    [self closeButtonPressed:self];
}

#pragma mark: - UIGestureRecognizerDelegate

- (IBAction)didPan:(UIPanGestureRecognizer *)sender {
    GenieAnimator * animator = (GenieAnimator *) [self.transitioningDelegate animationControllerForDismissedController:self];
    [animator handleOffstagePanWithPan: sender];
}

@end
