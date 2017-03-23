//
//  ViewModel.m
//  Lesson1
//
//  Created by Stefan Adams on 21/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModel.h"
#import "Lesson1-Swift.h"

@interface ViewModel ()


@end

@implementation ViewModel

#pragma mark - Initializers

FaroSwiftService *service;

-(id)initWithData: (NSArray*)data {
    self = [super init];
    
    [self fetchStaticData:data];
    
    return self;
}

-(id)initWithService: (FaroSwiftService*)service {
    self = [super init];
    self.service = service;
    return self;
}

#pragma mark - Configuration

- (NSInteger)numberOfRows {
    return self.ingredients.count;
}

- (NSString*)titleLabelText {
    return @"Ingrediënts";
}

#pragma mark - Fetch functions

-(void)fetchFaroData {
    PostService * postService = [[PostService alloc] init];
    
    [postService post:1 post:^(Post * _Nonnull post) {
        NSLog(@"%@", post);
    } fail:^(NSString * _Nonnull fail) {
        NSLog(@"%@", fail);
    }];
}

-(void)fetchStaticData: (NSArray*)data {
    if (data != nil) {
        self.ingredients = data;
    } else {
        self.ingredients = @[@"Brood", @"Spek", @"Kaas"];
    }
}

@end

