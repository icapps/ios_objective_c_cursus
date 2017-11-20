//
//  Post+Post_Service.h
//  ObjcTextInput
//
//  Created by Stijn Willems on 15/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//


#import "ObjcTextInput-Swift.h"

@class Post;

@interface Post (Post_Service)

+(Post const * const)getSingletonConstantPointerPost;
- (void) print:(NSArray <Post *>* )array;

@end
