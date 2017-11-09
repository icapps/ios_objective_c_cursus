//
//  TIIEnterTextViewController.h
//  ObjcTextInput
//
//  Created by Ronald Hollander on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TIIEnterTextViewController;

@protocol TIIEnterTextViewControllerDelegate <NSObject>
- (void) didFinishEnteringText:(NSString *)text;
@end

@interface TIIEnterTextViewController : UIViewController
@property (nonatomic, weak) id <TIIEnterTextViewControllerDelegate> delegate;
@end
