//
//  ViewModel.h
//  Objective-C
//
//  Created by Stijn Willems on 21/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Objective_C-Swift.h"

@interface ViewModel : NSObject

@property (nonatomic, strong) Post * post;
@property (nonatomic, strong) PostService * service;

- (id) initWithModels: (NSArray <NSString*> *) models;

- (NSNumber *) numberOfModels;

- (void) load;

@end
