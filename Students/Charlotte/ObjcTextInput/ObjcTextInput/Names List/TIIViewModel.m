//
//  TIIViewModel.m
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 16/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIIViewModel.h"

@interface TIIViewModel ()
@end

@implementation TIIViewModel

- (NSInteger)numberOfItems {
    if(self.names) {
        return self.names.count;
    } else {
        return 0;
    }
}

- (id)initWithDefaultConfiguration {
    if (self = [super init]) {
        self.names = [[NSMutableArray alloc] init];
        self.shouldEdit = NO;
        return self;
    } else {
        return nil;
    }
}

- (NSString *)objectForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.names.count && indexPath.row >= 0) {
        return self.names[indexPath.row];
    } else {
        return nil;
    }
}

- (void)swapObjectAtIndexPath:(NSIndexPath *)sourceIndexPath withObjectAtIndexPath:(NSIndexPath *)destinationIndexPath {
    if (self.names) {
        [self.names exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    }
}

- (void)addObject:(NSString *)newName {
    if (self.names) {
        [self.names addObject:newName];
    }
}

- (void)replaceObjectAtIndexPath:(NSIndexPath *)indexPath newName:(NSString *)newName {
    if (self.names) {
        self.names[indexPath.row] = newName;
    }
}

@end
