//
//  TIIUIViewController.m
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 9/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"
#import "TIIChangeTextViewController.h"

@interface TIIUIViewController () <ChangeTextDelegate>
@property (nonatomic, weak) IBOutlet UILabel * label;
@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.label setText:@"Ik heb niet gewonnen"];
}

- (void)didChangeText:(NSString *)changedText {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.label setText:changedText];
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[TIIChangeTextViewController class]]) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        TIIChangeTextViewController * controller = segue.destinationViewController;
        controller.delegate = self;
    }
    
}

@end
