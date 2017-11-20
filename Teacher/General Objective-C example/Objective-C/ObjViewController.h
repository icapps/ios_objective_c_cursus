//
//  ObjViewController.h
//  Objective-C
//
//  Created by Stijn Willems on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ObjcUpdateHandlerViewModel;
@class ObjViewController;

@protocol ObjViewControllerDelegate

- (void)objViewControllerDidEnd:(ObjViewController*) sender;

@end

@interface ObjViewController : UIViewController

@property (nonatomic, strong) ObjcUpdateHandlerViewModel * viewModel;
@property (nonatomic, weak) id<ObjViewControllerDelegate> delegate;



@end
