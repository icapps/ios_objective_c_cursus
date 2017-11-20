//
//  ViewController.m
//  Objective-C
//
//  Created by Stijn Willems on 21/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "ViewController.h"
#import "Objective_C-Swift.h"

@interface ViewController ()

@property (nonatomic, strong) PostService * service;
@property (nonatomic, strong) Post *post;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	__weak ViewController * weakSelf = self;
	[self.service post:1 post:^(Post * _Nonnull post) {
		weakSelf.post = post;
	} fail:^(NSString * _Nonnull error) {
		NSLog(@"%@", error);
	}];

	NSError *error;
	NSData * data = [@"{\"bla\":\"value\"}" dataUsingEncoding: NSUTF8StringEncoding];

	NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
														  options:NSJSONReadingAllowFragments
															error:&error];
	NSLog(@"%@", dict);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
