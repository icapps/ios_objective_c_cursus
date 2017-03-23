//
//  ObjcUpdateHandlerViewModel.m
//  Objective-C
//
//  Created by Stijn Willems on 23/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "ObjcUpdateHandlerViewModel.h"

@implementation ObjcUpdateHandlerViewModel

-(void)didLoadFromService {
	self.updateHandler([[Post alloc] initFrom: @{@"name": @"objective-c"}]);
}

@end
