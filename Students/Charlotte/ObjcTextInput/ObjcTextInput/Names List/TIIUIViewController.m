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

@interface TIIUIViewController () <UICollectionViewDataSource,UICollectionViewDelegate,TextDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, strong) TIIViewModel * viewModel;
@property (assign, nonatomic) BOOL isEditing;
@property (nonatomic, strong) UILongPressGestureRecognizer * longPressGesture;
@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewModel = [[TIIViewModel alloc] initWithDefaultConfiguration];
    
    self.isEditing = NO;
    
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)];
    [self.collectionView addGestureRecognizer:self.longPressGesture];

    [self.collectionView reloadData];
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

@end
