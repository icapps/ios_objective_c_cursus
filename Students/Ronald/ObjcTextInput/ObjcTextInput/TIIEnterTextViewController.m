//
//  TIIEnterTextViewController.m
//  ObjcTextInput
//
//  Created by Ronald Hollander on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIEnterTextViewController.h"

@interface TIIEnterTextViewController ()

@property (nonatomic, weak) IBOutlet UITextField *enterText;

@end

@implementation TIIEnterTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneTapped:(id)sender {
    [self.delegate didFinishEnteringText:self.enterText.text];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
