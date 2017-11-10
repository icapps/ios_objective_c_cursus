//
//  TIIReadLabelViewController.m
//  ObjcTextInput
//
//  Created by Ronald Hollander on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIReadLabelViewController.h"

@interface TIIReadLabelViewController ()
@property (strong, nonatomic) NSMutableArray<NSString *> * labelList;
@end

@implementation TIIReadLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelList = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didFinishEnteringText:(NSString *)text {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.labelList addObject:text];
        NSLog(@"%@", [self.labelList objectAtIndex:0]);
    }];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[TIIEnterTextViewController class]]) {
    TIIEnterTextViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.delegate = self;
    }
}

@end
