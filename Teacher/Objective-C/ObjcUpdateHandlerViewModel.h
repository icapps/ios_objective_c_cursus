//
//  ObjcUpdateHandlerViewModel.h
//  Objective-C
//
//  Created by Stijn Willems on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Objective_C-Swift.h"

@interface ObjcUpdateHandlerViewModel : NSObject

@property (nonatomic, copy, nullable) void (^updateHandler)(Post * _Nonnull post);

-(void) didLoadFromService;

@end
