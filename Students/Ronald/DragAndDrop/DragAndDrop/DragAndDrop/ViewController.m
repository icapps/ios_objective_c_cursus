//
//  ViewController.m
//  DragAndDrop
//
//  Created by Ronald Hollander on 15/11/2017.
//  Copyright © 2017 Ronald Hollander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UITextField *helloTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIDragInteraction *dragInteraction = [[UIDragInteraction alloc] initWithDelegate:self];
    UIDropInteraction *dropInteraction = [[UIDropInteraction alloc] initWithDelegate:self];
    [self.helloLabel addInteraction:dragInteraction];
    [self.tableView setDropDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull NSArray<UIDragItem *> *)dragInteraction:(nonnull UIDragInteraction *)interaction itemsForBeginningSession:(nonnull id<UIDragSession>)session {
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:[self.helloLabel text]];
    UIDragItem *item = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    [item setLocalObject:self.helloLabel];
    
    /*
     Returning a non-empty array, as shown here, enables dragging. You
     can disable dragging by instead returning an empty array.
     */
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:item, nil];
    return array;
}

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
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    
    [coordinator.session loadObjectsOfClass:NSString.self)  completion:<#^(NSArray<__kindof id<NSItemProviderReading>> * _Nonnull objects)completion#>]
    
    coordinator.session.loadObjects(ofClass: NSString.self) { items in
        // Consume drag items.
        let stringItems = items as! [String]
        
        var indexPaths = [IndexPath]()
        for (index, item) in stringItems.enumerated() {
            let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
            self.model.addItem(item, at: indexPath.row)
            indexPaths.append(indexPath)
        }
        
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
}

@end
