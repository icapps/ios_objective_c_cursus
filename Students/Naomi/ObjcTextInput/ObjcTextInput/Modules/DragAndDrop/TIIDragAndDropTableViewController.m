//
//  TIIDragAndDropTableViewController.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 16/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIDragAndDropTableViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface TIIDragAndDropTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *dragAndDropTableview;
@property (strong, nonatomic) NSMutableArray *values;
@end

@implementation TIIDragAndDropTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.values = [@[@"Appelen",@"Eieren",@"Spaghetti"] mutableCopy];

    [self.dragAndDropTableview setDragDelegate:self];
    [self.dragAndDropTableview setDropDelegate:self];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.values.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dragAndDropCell" forIndexPath:indexPath];
    cell.textLabel.text = self.values[indexPath.row];
    return cell;
}
-(NSArray<UIDragItem *> *)tableView:(UITableView *)tableView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
    return [self dragItemsforIndexpath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canHandleDropSession:(id<UIDropSession>)session {
    return YES;//[self tableView:self.dragAndDropTableview canHandleDropSession:session];
}

-(BOOL) canHandleSession:(id<UIDropSession>) session {
    return [session canLoadObjectsOfClass:NSString.self];
}

-(UITableViewDropProposal *)tableView:(UITableView *)tableView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath {

    if(self.dragAndDropTableview.hasActiveDrag){
        if (session.items.count>1) {
            return [[UITableViewDropProposal alloc]initWithDropOperation:UIDropOperationCancel];;
        } else {
            return [[UITableViewDropProposal alloc]initWithDropOperation:UIDropOperationMove intent:UITableViewDropIntentInsertIntoDestinationIndexPath];
        }
    } else {
        return [[UITableViewDropProposal alloc]initWithDropOperation:UIDropOperationCopy intent:UITableViewDropIntentInsertIntoDestinationIndexPath];;
    }
}

-(void)tableView:(UITableView *)tableView performDropWithCoordinator:(id<UITableViewDropCoordinator>)coordinator {
    NSIndexPath *destinationIndexPath = [[NSIndexPath alloc] init];
    if (coordinator.destinationIndexPath) {
        destinationIndexPath = coordinator.destinationIndexPath;
    } else {
        destinationIndexPath = [NSIndexPath indexPathForRow:[self.dragAndDropTableview numberOfRowsInSection:0] inSection:0];
    }

    [coordinator.session loadObjectsOfClass:NSString.self completion:^(NSArray<NSString*> * items) {
        NSMutableArray<NSIndexPath*> *indexpaths = [[NSMutableArray alloc] init];
        [items enumerateObjectsUsingBlock:^(NSString * item, NSUInteger index, BOOL  *stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(destinationIndexPath.row + index) inSection:destinationIndexPath.section];
            [self.values insertObject:item atIndex:(indexPath.row)];
            [indexpaths addObject:indexPath];
        }];
        [self.dragAndDropTableview insertRowsAtIndexPaths:indexpaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }];

}

- (NSArray<UIDragItem *> *) dragItemsforIndexpath:(NSIndexPath*) indexPath {
    NSString *selectedValue = self.values[indexPath.row];
    NSData *valueData = [selectedValue dataUsingEncoding:NSUTF8StringEncoding];
    NSItemProvider *itemProvider = [[NSItemProvider alloc]init];
    [itemProvider registerDataRepresentationForTypeIdentifier:(NSString *) kUTTypePlainText
                                                   visibility:(NSItemProviderRepresentationVisibilityAll)
                                                  loadHandler:^NSProgress * _Nullable(void (^ _Nonnull completionHandler)(NSData * _Nullable, NSError * _Nullable)) {

                                                      completionHandler(valueData, nil);
                                                      return nil;
    }];
    return @[[[UIDragItem alloc] initWithItemProvider:itemProvider]];
}
@end
