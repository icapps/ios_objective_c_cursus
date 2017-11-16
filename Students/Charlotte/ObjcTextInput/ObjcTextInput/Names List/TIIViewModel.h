//
//  TIIViewModel.h
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 16/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIIViewModel: NSObject
@property (nonatomic, strong) NSMutableArray <NSString *> * names;
@property (nonatomic, assign) BOOL * shouldEdit;
@property (nonatomic, readonly) NSInteger numberOfItems;
- (id)initWithDefaultConfiguration;
- (NSString *)objectForIndexPath: (NSIndexPath *) indexPath;
- (void)swapObjectAtIndexPath: (NSIndexPath *) sourceIndexPath withObjectAtIndexPath: (NSIndexPath *) destinationIndexPath;
- (void)addObject: (NSString *) newName;
- (void)replaceObjectAtIndexPath: (NSIndexPath *) indexPath newName: (NSString *) newName;
@end
