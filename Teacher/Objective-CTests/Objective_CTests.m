//
//  Objective_CTests.m
//  Objective-CTests
//
//  Created by Stijn Willems on 21/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ViewModel.h"
#import "ViewModelService.h"

@import Nimble;
@import Quick;
@import Faro;

@interface Objective_CTests : QuickSpec

@end

@implementation Objective_CTests

-(void)spec {

	describe(@"ViewModel List helpers", ^{

		it(@"instantiates from models", ^ {

			id mockArray = OCMClassMock([NSArray class]);
			[OCMStub([mockArray count]) andReturnValue: OCMOCK_VALUE(30)];

			ViewModel* viewModel = [[ViewModel alloc] initWithModels:mockArray];

			expect([viewModel numberOfModels]).to(equal(@30));
		});

		it(@"load from service", ^ {
			NSArray<NSString *> *empty = @[@""];

			ViewModel* viewModel = [[ViewModel alloc] initWithModels:empty];

			id postService = OCMClassMock([ViewModelService class]);
			viewModel.fakeService = postService;
			
			NSDictionary * dict = @{@"name": @"Stijn"};
			[OCMStub([postService postDictionary]) andReturn: dict];

			[viewModel load];

			expect(viewModel.name).to(equal(@"Stijn"));
		});
		
	});

}


@end
