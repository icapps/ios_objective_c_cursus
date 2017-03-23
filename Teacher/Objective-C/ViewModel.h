//
//  ViewModel.h
//  Objective-C
//
//  Created by Stijn Willems on 21/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelService.h"

@interface ViewModel : NSObject


@property (nonatomic, strong) ViewModelService * fakeService;

- (NSString *) name;

- (id) initWithModels: (NSArray <NSString*> *) models;

- (NSNumber *) numberOfModels;

- (void) load;

@end
