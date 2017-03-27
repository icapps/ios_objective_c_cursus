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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.service = [[PostService alloc] init];
    }
    return self;
}
#pragma MARK: - Service

- (void) load:(void (^)(void))done {
    __weak ViewModel *weakSelf = self;
    [self.service postWithPosts:^(NSArray<Post *> * _Nonnull posts) {
        weakSelf.posts = posts;
        done();
    } fail:^(NSString * _Nonnull fail) {
         NSLog(@"%@", fail);
    }];
}

- (PostDetailViewModel *) postDetailViewModelAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _posts.count) {
        return [[PostDetailViewModel alloc] initWithPost: self.posts[indexPath.row]];
    } else {
        return nil;
    }
}

@end
