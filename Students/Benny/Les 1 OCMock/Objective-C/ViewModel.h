//
//  ViewModel.h
//  Objective-C
//
//  Created by Stijn Willems on 21/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Objective_C-Swift.h"
#import "PostDetailViewModel.h"

@interface ViewModel : NSObject

@property (nonatomic, strong) NSArray <Post *> *posts;
@property (nonatomic, strong) PostService * service;

- (void) load: (void (^)(void))done;
- (PostDetailViewModel *) postDetailViewModelAtIndexPath: (NSIndexPath *) indexPath;
@end
