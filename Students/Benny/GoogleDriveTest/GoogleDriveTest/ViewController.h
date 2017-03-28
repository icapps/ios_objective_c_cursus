//
//  ViewController.h
//  GoogleDriveTest
//
//  Created by Ben Algoet on 28/03/2017.
//  Copyright © 2017 Ben Algoet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLRDrive.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) GTLRDriveService *service;
@property (nonatomic, strong) UITextView *output;

@end

