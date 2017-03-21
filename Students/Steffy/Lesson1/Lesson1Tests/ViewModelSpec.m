//
//  ViewModelSpec.m
//  Lesson1Tests
//
//  Created by Stefan Adams on 21/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "ViewModel.h"

@import Quick;
@import Nimble;

@interface ViewModelSpec : QuickSpec

@property (strong, nonatomic) ViewModel* viewModel;

@end

@implementation ViewModelSpec

- (void)spec {
    describe(@"Translations", ^{
        beforeEach(^{
            self.viewModel = [[ViewModel alloc] initWithData:nil];
        });
        
        it(@"should give the correct title for the main screen", ^{
            expect(self.viewModel.titleLabelText).to(equal(@"Ingrediënts"));
        });
    });
    
    describe(@"TableView", ^{
        beforeEach(^{
            self.viewModel = [[ViewModel alloc] initWithData:nil];
        });
        
        it(@"should return the correct number of rows for the tableView", ^{
            expect(self.viewModel.numberOfRows).to(equal(self.viewModel.ingredients.count));
        });
    });
    
    describe(@"MockedTableViewData", ^{
        it(@"should return the correct data from a mocked array.", ^{
            id mockArray = OCMClassMock([NSArray class]);
            [OCMStub([mockArray count]) andReturnValue: OCMOCK_VALUE(10)];
            
            ViewModel* viewModel = [[ViewModel alloc] initWithData:mockArray];
            expect(viewModel.numberOfRows).to(equal(@10));
        });
    });
}

@end
