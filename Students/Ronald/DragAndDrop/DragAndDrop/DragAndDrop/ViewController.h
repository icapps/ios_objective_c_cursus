//
//  ViewController.h
//  DragAndDrop
//
//  Created by Ronald Hollander on 15/11/2017.
//  Copyright © 2017 Ronald Hollander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIDragInteractionDelegate, UIDropInteractionDelegate, UITableViewDropDelegate, UITableViewDragDelegate>

-(NSMutableArray<UIDragItem *> *) dragItemsForIndexPath:(NSIndexPath *) indexPath;
@end

