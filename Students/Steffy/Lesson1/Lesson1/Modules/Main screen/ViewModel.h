//
//  ViewModel.h
//  Lesson1
//
//  Created by Stefan Adams on 21/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lesson1-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel: NSObject

- (id)initWithService: (PostService*)service;



#pragma mark - Configuration

@property (readonly) NSString* titleLabelText;

@property (readonly) NSInteger numberOfRows;

- (Post*)postAtIndexPath: (NSIndexPath*)indexPath;

#pragma mark - Service

@property (strong, nonatomic) PostService* service;
@property (nonatomic, strong) void (^updateHandler) (void);

- (void)fetchPosts;

@end

NS_ASSUME_NONNULL_END
