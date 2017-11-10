//
//  TIITextInputViewController.h
//  ObjcTextInput
//
//  Created by Stijn Willems on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ObjcTextInput-Swift.h"

@class TIITextInputViewController;

@protocol TIITextInputViewControllerDelegate
- (void)textInputViewController: (TIITextInputViewController *) sender doneWithText: (NSString *) text;
@end

@interface TIITextInputViewController : UIViewController

@property (nonatomic, weak) id<TIITextInputViewControllerDelegate> delegate;
@property (nonatomic, strong) TextViewModel * viewModel;

@end
