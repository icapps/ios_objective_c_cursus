//
//  TIIChangeTextViewController.h
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 9/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TIIChangeTextViewController;

@protocol TextDelegate
@required
-(void)didAddText: (NSString *) newText;
-(void)didEditText: (NSString *) editedText :(NSIndexPath *) itemIndex;
@end

@interface TIIChangeTextViewController: UIViewController
@property (nonatomic, weak) id<TextDelegate> delegate;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, assign) NSIndexPath * itemIndex;
@end
