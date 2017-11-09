//
//  TIIChangeTextViewController.h
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 9/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TIIChangeTextViewController;

@protocol ChangeTextDelegate
@required
-(void)didChangeText: (NSString *) changedText;
@end

@interface TIIChangeTextViewController : UIViewController
@property (nonatomic, weak) id<ChangeTextDelegate> delegate;
@end
