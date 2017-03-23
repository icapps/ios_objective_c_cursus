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

#pragma mark - Model data

@property (strong, nonatomic) NSArray <Post*> *posts;

@end

@implementation ViewModel

-(id)initWithService: (PostService*)service {
    self = [super init];
    self.service = service;
    return self;
}

#pragma mark - Configuration

- (NSInteger)numberOfRows {
    return self.posts.count;
}

- (NSString*)titleLabelText {
    return @"Ingrediënts";
}

#pragma mark - Service

-(void) fetchPosts {
    
    __weak ViewModel* weakSelf = self;
    [self.service allPostsWithPost:^(NSArray<Post *> * _Nonnull posts) {
        weakSelf.posts = posts;
        weakSelf.updateHandler();
    }fail:^(NSString * _Nonnull fail) {
        NSLog(@"%@", fail);
    }];
}

@end

