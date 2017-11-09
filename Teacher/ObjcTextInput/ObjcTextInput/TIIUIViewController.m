//
//  UIViewController.m
//  ObjcTextInput
//
//  Created by Stijn Willems on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"

@interface TIIUIViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label.text = @"Ik ben gewonnen!";
}

@end
