//
//  ViewModel.m
//  Lesson1
//
//  Created by Stefan Adams on 21/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModel.h"

@interface ViewModel ()

@end

@implementation ViewModel

// MARK: - Initializers

-(id)initWithData: (NSArray*)data {
    self = [super init];
    
    if (data != nil) {
        self.ingredients = data;
    } else {
        self.ingredients = @[@"Brood", @"Spek", @"Kaas"];
    }
    
    return self;
}

// MARK: - Configuration

- (NSInteger)numberOfRows {
    return self.ingredients.count;
}

- (NSString*)titleLabelText {
    return @"Ingrediënts";
}

@end

