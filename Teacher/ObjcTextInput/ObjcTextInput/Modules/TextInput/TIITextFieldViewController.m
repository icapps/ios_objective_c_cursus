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

@interface TIITextFieldViewController ()

@property (weak, nonatomic) IBOutlet UITextField * valueTextField;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;

@end

@implementation TIITextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Dismiss and Present are the same animator so we only call this dismiss
    GenieAnimator * animator = (GenieAnimator *) [self.transitioningDelegate animationControllerForDismissedController:self];
    self.panGesture.delegate = animator;

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

@end
