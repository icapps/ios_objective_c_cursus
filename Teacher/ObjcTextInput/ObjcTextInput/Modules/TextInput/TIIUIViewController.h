//
//  TIIUIViewController.h
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIITextFieldViewController.h"

static int const globalValue = 10;
static int const * const global = &globalValue;


@interface TIIUIViewController : UIViewController <EditingValueFinishedDelegate, UICollectionViewDataSource>

@property (nonatomic) BOOL showPosts;

@end
