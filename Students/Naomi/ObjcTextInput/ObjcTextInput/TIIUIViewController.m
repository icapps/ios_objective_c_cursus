//
//  TIIUIViewController.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"

@interface TIIUIViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = @"Spaghetti";
}

- (void) editingValueFinished:(NSString *)value {
    [self dismissViewControllerAnimated:YES completion:^{
        self.label.text = value;
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[TIITextFieldViewController class]]) {
        TIITextFieldViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.delegate = self;

    }
}

@end
