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
#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

@interface Objective_CTests : QuickSpec

@end

@implementation Objective_CTests


- (void)testViewModelInstantiation {
	ViewModel* viewModel = [[ViewModel alloc] init];

}


@end
