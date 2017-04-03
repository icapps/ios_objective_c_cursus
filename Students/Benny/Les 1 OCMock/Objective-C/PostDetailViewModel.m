//
//  PostDetailViewModel.m
//  Objective-C
//
//  Created by Ben Algoet on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "PostDetailViewModel.h"

@interface PostDetailViewModel()

@end

@implementation PostDetailViewModel

- (id) initWithPost:(Post *)post {
    self = [super init];
    if(self) {
        self.post = post;
    }
    return self;
}


#pragma MARK: - Variables
-(NSNumber *) postId {
    return self.post.id;
}

-(NSString *) title {
    return self.post.title;
}

@end
