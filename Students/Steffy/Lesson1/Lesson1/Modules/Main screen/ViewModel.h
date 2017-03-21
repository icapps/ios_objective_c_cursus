//
//  ViewModel.h
//  Lesson1
//
//  Created by Stefan Adams on 21/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewModel: NSObject {
    
}

@property (strong, nonatomic) NSArray* ingredients;
@property (readonly) NSInteger numberOfRows;

// MARK: - Init

- (id)initWithData: (NSArray*)data;

// MARK: - Translations

@property (readonly) NSString* titleLabelText;

@end
