//
//  ViewModel.m
//  Objective-C
//
//  Created by Stijn Willems on 21/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "ViewModel.h"

@interface ViewModel()

@property (nonatomic, strong) NSArray <NSString*> * models;

@end

@implementation ViewModel

- (id)initWithModels:(NSArray<NSString *> *)models {
	self = [super init];
	if (self) {
		self.models = models;
	}
	return self;
}

- (NSNumber *)numberOfModels {
	NSLog(@"%@", @(self.models.count));
	return @(self.models.count);
}

@end
