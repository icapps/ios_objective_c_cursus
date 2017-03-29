//
//  ViewModel.m
//  Objective-C
//
//  Created by Stijn Willems on 21/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "ViewModel.h"
#import "Objective_C-Swift.h"

@interface ViewModel()

@property (nonatomic, strong) NSArray <NSString*> * models;
@property (nonatomic, strong) Post * post;
@property (nonatomic, strong) PostService * service;

@end

@implementation ViewModel

- (id)initWithModels:(NSArray<NSString *> *)models {
	self = [super init];
	if (self) {
		self.models = models;
		self.service = [[PostService alloc] init];
		self.fakeService = [[ViewModelService alloc] init];
	}
	return self;
}

- (NSNumber *)numberOfModels {
	NSLog(@"%@", @(self.models.count));
	return @(self.models.count);
}

- (NSString *)name {
	return self.post.name;
}

#pragma MARK: - Service

- (void) load {
	self.post = [[Post alloc] initFrom:[self.fakeService postDictionary]];
//	[self.service post:1 post:^(Post * _Nonnull post) {
//		self.post = post;
//	} fail:^(NSString * _Nonnull fail) {
//		NSLog(@"%@", fail);
//	}];
}

@end
