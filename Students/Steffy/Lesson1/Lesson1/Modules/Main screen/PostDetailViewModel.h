//
//  PostDetailViewModel.h
//  Pods
//
//  Created by Stijn Willems on 23/03/2017.
//
//

#import <Foundation/Foundation.h>
#import "Lesson1-Swift.h"

@interface PostDetailViewModel : NSObject

-(id)initWithPost: (Post *) post;

@property (readonly) NSString * title;

@end
