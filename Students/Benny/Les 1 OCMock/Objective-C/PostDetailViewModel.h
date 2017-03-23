//
//  PostDetailViewModel.h
//  Objective-C
//
//  Created by Ben Algoet on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Objective_C-Swift.h"

@interface PostDetailViewModel : NSObject

@property (nonatomic, strong) Post * post;

- (id) initWithPost: (Post *) post;

@end
