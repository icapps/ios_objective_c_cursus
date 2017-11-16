//
//  ViewController.m
//  DragAndDrop
//
//  Created by Ronald Hollander on 15/11/2017.
//  Copyright © 2017 Ronald Hollander. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UITextField *helloTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<NSString *> * names;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIDragInteraction *dragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    UIDropInteraction *dropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
    [self.helloLabel addInteraction:dragInteraction];
    self.names = [@[@"Ronald", @"Charlotte", @"Stijn", @"Naomi"]mutableCopy];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setDragDelegate:self];
    [self.tableView setDropDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - Normal Drag Interaction

- (nonnull NSArray<UIDragItem *> *)dragInteraction:(nonnull UIDragInteraction *)interaction itemsForBeginningSession:(nonnull id<UIDragSession>)session {
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:[self.helloLabel text]];
    UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    [item setLocalObject:self.helloLabel];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:item, nil];
    return array;
}

// MARK: - Table View Delegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"myCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.textLabel setText:self.names[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.names count];
}

// MARK: - Table Drag Interaction

- (nonnull NSArray<UIDragItem *> *)tableView:(nonnull UITableView *)tableView itemsForBeginningDragSession:(nonnull id<UIDragSession>)session atIndexPath:(nonnull NSIndexPath *)indexPath {
    return [self dragItemsForIndexPath:indexPath];
}

-(NSMutableArray<UIDragItem *> *) dragItemsForIndexPath:(NSIndexPath *) indexPath {
    NSString * name = self.names[indexPath.row];
    NSData * data = [name dataUsingEncoding:NSUTF8StringEncoding];

    NSItemProvider *itemProvider = [[NSItemProvider alloc] init];
    
    [itemProvider registerDataRepresentationForTypeIdentifier: (NSString *) kUTTypePlainText visibility:NSItemProviderRepresentationVisibilityAll loadHandler:^ NSProgress * _Nullable(void (^ _Nonnull completionHandler)(NSData * _Nullable, NSError * _Nullable)) {
        completionHandler(data, nil);
        return nil;
    }];
    UIDragItem * dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    NSMutableArray<UIDragItem *> * dragItems = [[NSMutableArray alloc] init];
    [dragItems addObject:dragItem];
    return dragItems;
}

// MARK- Table Drop Interaction

-(BOOL)tableView:(UITableView *)tableView canHandleDropSession:(id<UIDropSession>)session {
    return YES;
}

-(BOOL)dropInteraction:(UIDropInteraction *)interaction canHandleSession:(id<UIDropSession>)session {
    return [session canLoadObjectsOfClass:NSString.self];
}

-(UITableViewDropProposal *)tableView:(UITableView *)tableView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath {
    UITableViewDropProposal *proposal = [[UITableViewDropProposal alloc] initWithDropOperation: UIDropOperationCopy intent: UITableViewDropIntentInsertIntoDestinationIndexPath];
    return proposal;
}

- (void)tableView:(nonnull UITableView *)tableView performDropWithCoordinator:(nonnull id<UITableViewDropCoordinator>)coordinator {
    NSIndexPath *destinationIndexPath = [[NSIndexPath alloc] init];
    if (coordinator.destinationIndexPath) {
        destinationIndexPath = coordinator.destinationIndexPath;
    } else {
        destinationIndexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] inSection:0];
    }
    
    [coordinator.session loadObjectsOfClass:NSString.self completion:^(NSArray<NSString *> * items) {
        NSMutableArray<NSIndexPath *> * indexPaths = [[NSMutableArray alloc] init];
        [items enumerateObjectsUsingBlock:^(NSString * item, NSUInteger index, BOOL *stop) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:destinationIndexPath.row + index inSection:destinationIndexPath.section];
            [self.names insertObject:item atIndex:indexPath.row];
            [indexPaths addObject:indexPath];
        }];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    }

@end
