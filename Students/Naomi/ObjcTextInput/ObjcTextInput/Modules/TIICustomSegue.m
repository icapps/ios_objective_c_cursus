//
//  TIICustomSegue.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 20/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIICustomSegue.h"

@implementation TIICustomSegue

-(void)perform {
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];
}

@end
