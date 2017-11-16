//
//  TIITextFieldViewController.h
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TIITextFieldViewController;

@protocol EditingValueFinishedDelegate

@required
- (void) editingValueFinished:(NSString*) value isNewName:(BOOL) isNew;

@end
@interface TIITextFieldViewController : UIViewController

@property (weak, nonatomic) NSString *currentName;

@property (nonatomic, weak) id<EditingValueFinishedDelegate> editingDelegate;

- (void) itsTimeToDismiss;
@end


