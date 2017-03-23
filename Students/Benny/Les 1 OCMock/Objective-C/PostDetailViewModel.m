//
//  PostDetailViewModel.m
//  Objective-C
//
//  Created by Ben Algoet on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "PostDetailViewModel.h"

@interface PostDetailViewModel()

@property (nonatomic) NSNumber * postId;

@end

@implementation PostDetailViewModel

- (id) initWithPost:(Post *)post {
    self = [super init];
    if(self) {
        self.post = post;
        _postId = post.id;
    }
    return self;
}



@end
