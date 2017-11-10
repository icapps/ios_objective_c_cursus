//
//  TIIChangeTextViewController.m
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 9/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIChangeTextViewController.h"

@interface TIIChangeTextViewController ()
@property (nonatomic, weak) IBOutlet UITextField * textField;
@end

@implementation TIIChangeTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeController:(id)sender {
    NSString * text = self.textField.text;
    
    if (self.itemIndex) {
        [self.delegate didEditText:text :self.itemIndex];
    } else {
        [self.delegate didAddText:text];
    }
    
}

@end
