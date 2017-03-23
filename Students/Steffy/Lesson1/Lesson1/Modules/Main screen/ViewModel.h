//
//  ViewModel.h
//  Lesson1
//
//  Created by Stefan Adams on 21/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lesson1-Swift.h"


@interface ViewModel: NSObject 

@property (strong, nonatomic) NSArray* ingredients;
@property (strong, nonatomic) NSArray <Post*> *posts;
@property (readonly) NSInteger numberOfRows;
@property (strong, nonatomic) FaroSwiftService* service;

#pragma mark - Init

- (id)initWithData: (NSArray*)data;
- (id)initWithService: (FaroSwiftService*)service;

#pragma mark - Functions

- (void)fetchStaticData: (NSArray*)data;
- (void)fetchFaroData;
- (void)fetchAllFaroData;

#pragma mark - Translations

@property (readonly) NSString* titleLabelText;

@end
