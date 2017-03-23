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

@property (strong, nonatomic, nonnull) NSArray* ingredients;
@property (strong, nonatomic, nonnull) NSArray <Post*> *posts;
@property (readonly) NSInteger numberOfRows;
@property (strong, nonatomic, nonnull) FaroSwiftService* service;

#pragma mark - updateHandler

@property (nonatomic, strong, nonnull) void (^updateHandler) (void);

#pragma mark - Init

- (id _Nonnull)initWithData: (NSArray* _Nonnull)data;
- (id _Nonnull)initWithService: (FaroSwiftService* _Nonnull)service;

#pragma mark - Functions

- (void)fetchStaticData: (NSArray* _Nonnull)data;
- (void)fetchFaroData;
- (void)fetchAllFaroData:(void (^ _Nonnull)(void))completion;

#pragma mark - Translations

@property (readonly) NSString* _Nonnull titleLabelText;

@end
