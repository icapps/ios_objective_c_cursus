//
//  TIIReadLabelViewController.m
//  ObjcTextInput
//
//  Created by Ronald Hollander on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIReadLabelViewController.h"

@interface TIIReadLabelViewController ()
@property (weak, nonatomic) IBOutlet UILabel *readLabel;

@end

@implementation TIIReadLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.readLabel.text = @"Hello Again";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TIIEnterTextViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.delegate = self;
}


- (void)didFinishEnteringText:(NSString *)text {
    self.readLabel.text = text;
}

@end
