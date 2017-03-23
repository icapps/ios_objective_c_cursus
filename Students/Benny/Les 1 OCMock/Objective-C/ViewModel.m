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

@end

@implementation ViewModel

- (id)initWithModels:(NSArray<NSString *> *)models {
	self = [super init];
	if (self) {
		self.models = models;
        self.service = [[PostService alloc] init];
	}
	return self;
}

- (NSNumber *)numberOfModels {
	NSLog(@"%@", @(self.models.count));
	return @(self.models.count);
}

#pragma MARK: - Service

- (void) load:(void (^)(void))done {
    self.service = [[PostService alloc] init];
    [self.service postWithPosts:^(NSArray<Post *> * _Nonnull posts) {
        self.posts = posts;
        done();
    } fail:^(NSString * _Nonnull fail) {
         NSLog(@"%@", fail);
    }];
}

@end
