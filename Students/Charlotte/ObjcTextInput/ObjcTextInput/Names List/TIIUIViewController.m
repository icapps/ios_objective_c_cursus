//
//  TIIUIViewController.m
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 9/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"
#import "TIIChangeTextViewController.h"
#import "TIILabelCollectionViewCell.h"
#import "TIIViewModel.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface TIIUIViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDragDelegate,UICollectionViewDropDelegate,UIViewControllerPreviewingDelegate,TextDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, strong) TIIViewModel * viewModel;
@property (assign, nonatomic) BOOL isEditing;
@property (nonatomic, strong) UILongPressGestureRecognizer * longPressGesture;
@property (nonatomic, strong) id previewingContext;
@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewModel = [[TIIViewModel alloc] initWithDefaultConfiguration];
    
    self.collectionView.dragDelegate = self;
    self.collectionView.dropDelegate = self;
    
    self.isEditing = NO;
    
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
    [self.collectionView addGestureRecognizer:self.longPressGesture];

    [self.collectionView reloadData];
    
    if([self isForceTouchAvailable]) {
        self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
}

#pragma mark - UILongPressGesture

- (void)handleLongGesture:(UILongPressGestureRecognizer *)gesture {
    NSIndexPath * selectedIndexPath;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            selectedIndexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            
            if (selectedIndexPath) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            }
            break;
        case UIGestureRecognizerStateChanged:
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.numberOfItems;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"LabelCell";
    
    TIILabelCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString * cellText = [self.viewModel objectForIndexPath:indexPath];
    [cell configureWithString:cellText isInEditMode:self.isEditing];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.isEditing;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.viewModel swapObjectAtIndexPath:sourceIndexPath withObjectAtIndexPath:destinationIndexPath];
}

#pragma mark - TextDelegate

-(void)didAddText:(NSString *)newText {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.viewModel addObject:newText];
        NSArray * lastIndexPaths = @[[NSIndexPath indexPathForRow:self.viewModel.numberOfItems-1 inSection:0]];
        [self.collectionView insertItemsAtIndexPaths:lastIndexPaths];
    }];
}

-(void)didEditText:(NSString *)editedText
       atItemIndex:(NSIndexPath *)itemIndex {

    [self dismissViewControllerAnimated:YES completion:^{
        if (itemIndex.row < self.viewModel.numberOfItems) {
            [self.viewModel replaceObjectAtIndexPath:itemIndex newName:editedText];
            [self.collectionView reloadItemsAtIndexPaths:@[itemIndex]];
        }
    }];
}

#pragma mark - Actions

- (IBAction)toggleEditCollectionViewMode:(UIBarButtonItem *)sender {
    self.isEditing = !self.isEditing;
    
    for(TIILabelCollectionViewCell *cell in self.collectionView.visibleCells){
        [cell toggleEditMode:self.isEditing];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[TIIChangeTextViewController class]]) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        TIIChangeTextViewController * controller = segue.destinationViewController;
        controller.delegate = self;
        
        if ([segue.identifier isEqualToString:@"Edit"]) {
            NSIndexPath * selectedItemIndex = [[self.collectionView indexPathsForSelectedItems] firstObject];
            controller.itemIndex = selectedItemIndex;
            //controller.originalText = self.textArray[[[self.collectionView indexPathsForSelectedItems] firstObject].row];
            controller.originalText = [self.viewModel objectForIndexPath:selectedItemIndex];
        }
    }
}

#pragma mark - UICollectionViewDragDelegate

-(NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView
            itemsForBeginningDragSession:(id<UIDragSession>)session
                             atIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray <UIDragItem *> * dragItems = [[NSMutableArray alloc] init];
    
    NSItemProvider * itemProvider = [[NSItemProvider alloc] init];
    
    UIDragItem * dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];
    NSData * dataToSend = [[self.viewModel objectForIndexPath:indexPath] dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [itemProvider registerDataRepresentationForTypeIdentifier:(NSString *) kUTTypePlainText
                                                   visibility:(NSItemProviderRepresentationVisibilityAll)
                                                  loadHandler:^NSProgress * _Nullable(void (^ _Nonnull completionHandler)(NSData * _Nullable, NSError * _Nullable)) {
                                                      completionHandler(dataToSend, nil);
                                                      return nil;
    }];
    [dragItems addObject:dragItem];
    
    return dragItems;
}

#pragma mark - UICollectionViewDropDelegate

-(void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator {
    if(coordinator.items) {
       
        for(id<UICollectionViewDropItem> item in coordinator.items) {
            if(item.sourceIndexPath) {
                // TODO: Update viewModel, test drag and return
                [self.collectionView performBatchUpdates:^{
                    [self.collectionView deleteItemsAtIndexPaths:@[item.sourceIndexPath]];
                    [self.collectionView insertItemsAtIndexPaths:@[coordinator.destinationIndexPath]];
                } completion:^(BOOL finished) {
                    [coordinator dropItem:item toItemAtIndexPath:coordinator.destinationIndexPath];
                }];
            } else if(item.dragItem.localObject) {
                [self.viewModel addObject:item.dragItem.localObject];
                NSIndexPath * lastIndexPath = [NSIndexPath indexPathForRow:self.viewModel.numberOfItems-1 inSection:0];
                NSArray * lastIndexPaths = @[lastIndexPath];
                [self.viewModel.names insertObject:item.dragItem.localObject atIndex:lastIndexPath.row];
                [self.collectionView insertItemsAtIndexPaths:lastIndexPaths];
            } else {
                [item.dragItem.itemProvider loadObjectOfClass:NSString.self
                                            completionHandler:^(NSString * item, NSError * _Nullable error) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(coordinator.destinationIndexPath.row) inSection:coordinator.destinationIndexPath.section];
                        [self.viewModel.names insertObject:item atIndex:indexPath.row];
                        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
                    });
                }];
            }
            
        }
    }
}

#pragma mark - UIViewControllerPreviewingDelegate

-(BOOL)isForceTouchAvailable {
    BOOL isForceTouchAvailable = NO;
    
    if([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
        isForceTouchAvailable = self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
    }
    
    return isForceTouchAvailable;
}

-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    CGPoint cellPosition = [self.collectionView convertPoint:location fromView:self.view];
    NSIndexPath * indexPath = [self.collectionView indexPathForItemAtPoint:cellPosition];
    
    if(indexPath) {
        TIILabelCollectionViewCell * cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TIIChangeTextViewController * previewController = [storyboard instantiateViewControllerWithIdentifier:@"TIIChangeTextViewController"];
        
        previewController.originalText = [self.viewModel objectForIndexPath:indexPath];
        previewController.itemIndex = indexPath;
        
        previewingContext.sourceRect = [self.view convertRect:cell.frame fromView:self.collectionView];
        
        return previewController;
    }
    
    return nil;
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    TIIChangeTextViewController * changeTextViewController = viewControllerToCommit;
    changeTextViewController.delegate = self;
    [self presentViewController:changeTextViewController animated:YES completion:nil];
}

@end

























