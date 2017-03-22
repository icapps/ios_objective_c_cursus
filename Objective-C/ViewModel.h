//
//  ViewModel.h
//  Objective-C
//
//  Created by Stijn Willems on 21/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

- (id) initWithModels: (NSArray <NSString*> *) models;

- (NSNumber *) numberOfModels;

@end
