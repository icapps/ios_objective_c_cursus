//
//  PostDetailViewModel.m
//  Pods
//
//  Created by Stijn Willems on 23/03/2017.
//
//

#import "PostDetailViewModel.h"

@interface PostDetailViewModel ()

@property (nonatomic, strong) Post * post;

@end

@implementation PostDetailViewModel

-(NSString *)title {
	return  [NSString stringWithFormat:@"%@ %@", self.post.title, self.post.id] ;
}

- (id)initWithPost:(Post *)post {
	self = [super init];
	if (self ) {
		self.post = post;
	}

	return  self;
}


@end
