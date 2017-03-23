//
//  ObjViewController.m
//  Objective-C
//
//  Created by Stijn Willems on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "ObjViewController.h"
#import "ObjcUpdateHandlerViewModel.h"

@interface ObjViewController ()

@property (nonatomic, strong) ObjcUpdateHandlerViewModel * viewModel;
@end

@implementation ObjViewController


-(void)viewDidLoad {
	[super viewDidLoad];

	self.viewModel = [[ObjcUpdateHandlerViewModel alloc] init];
	self.viewModel.updateHandler = ^ (Post * post) {
		NSLog(@"update %@", post);
	};

}

@end
