//
//  Post+Post_Service.m
//  ObjcTextInput
//
//  Created by Stijn Willems on 15/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "Post+Post_Service.h"
#import "ObjcTextInput-Swift.h"

@implementation Post (Post_Service)

+(Post const * const)getSingletonConstantPointerPost {
    static Post const *  inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[Post alloc] initWithId:1
                                message:@"singleton instance"
                                  title:@"const pointer"
                                 userId:1];
    });
    return inst;
}

-(void) print:(NSArray <Post *>* )array {

    for (NSInteger i = 0; i< array.count; i++) {
        NSLog(@"%@", array[i]);
    }

    for (Post* post in array) {
        NSLog(@"%@", post);
    }
}

@end
