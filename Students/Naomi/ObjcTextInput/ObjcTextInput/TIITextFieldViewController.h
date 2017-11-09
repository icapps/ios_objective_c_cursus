//
//  TIITextFieldViewController.h
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditingValueFinishedDelegate;

@class TIITextFieldViewController;

@protocol EditingValueFinishedDelegate

- (void) editingValueFinished:(NSString*) value;

@end

@interface TIITextFieldViewController : UIViewController

@property (nonatomic, weak) id<EditingValueFinishedDelegate> delegate;

@end
