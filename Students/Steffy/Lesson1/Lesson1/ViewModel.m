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

//NSArray <NSString*> *ingredients = [NSArray arrayWithObjects:@"Brood", @"Spek", @"Kaas", nil];

-(id) init {
    self = [super init];
    self.ingredients = @[@"Brood", @"Spek", @"Kaas"];
    return self;
}

@end

