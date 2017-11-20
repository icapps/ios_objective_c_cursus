//
//  TIIUIViewController.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"
#import "TIILabelCollectionViewCell.h"
#import "ObjcTextInput-Swift.h"

@import Faro;

@interface TIIUIViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *labelCollectionView;
@property (strong, nonatomic) NSMutableArray *names;
@property (assign, nonatomic) NSInteger indexPathRow;
@property (nonatomic, strong) PostService * service;
@property (nonatomic, strong) id previewContext;
@property (nonatomic) BOOL canEdit;
@property (nonatomic, strong) TIITransitionManager *transitionManager;

@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.service = [[PostService alloc] init];
    self.transitionManager = [[TIITransitionManager alloc] init];
    self.canEdit = NO;

    UIPasteConfiguration * config = [[UIPasteConfiguration alloc]init];
    self.view.pasteConfiguration = config;

    if([self isForceTouchAvailable]) {
        self.previewContext = [self registerForPreviewingWithDelegate:self sourceView:self.labelCollectionView];
    }

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.labelCollectionView addGestureRecognizer:longPress];

    if (!self.showPosts) {
        self.names = [@[@"Ronald",@"Charlotte",@"Stijn"] mutableCopy];
    } else {
        __weak TIIUIViewController * weakSelf = self;
        [self.service getPosts:^{
            NSArray <Post *>* posts = weakSelf.service.posts;
            NSMutableArray <NSString *> *mapped = [NSMutableArray arrayWithCapacity:[posts count]];
            [posts enumerateObjectsUsingBlock:^(Post * post, NSUInteger idx, BOOL *stop) {
                [mapped addObject:post.title];
            }];
            weakSelf.names = mapped;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [weakSelf.labelCollectionView reloadData];
            }];
        }];
    }

    TIISlideInCollectionViewLayout * layout = (TIISlideInCollectionViewLayout*) self.labelCollectionView.collectionViewLayout;
    layout.translation = [[Translation alloc] initWithX:300 y:0];
}
- (IBAction)addButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"addNameSegue" sender:self];
}

#pragma mark - Peek and Pop

- (nullable UIViewController *)previewingContext:(nonnull id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    if ([self.presentedViewController isKindOfClass:[TIIUIViewController class]]) {
        return nil;
    }
    NSIndexPath *path = [self.labelCollectionView indexPathForItemAtPoint:location];
    if (path) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TextField" bundle:nil];

        TIITextFieldViewController *previewController = [storyboard instantiateViewControllerWithIdentifier:@"TIITextFieldViewController"];
        self.indexPathRow = path.row;
        previewController.delegate = self;
        previewController.currentName = self.names[path.row];
        return previewController;
    }
    return nil;
}

- (void)previewingContext:(id )previewingContext commitViewController: (UIViewController *)viewControllerToCommit {
    [self presentViewController:viewControllerToCommit animated:YES completion:nil];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if ([self isForceTouchAvailable]) {
        if (!self.previewContext) {
            self.previewContext = [self registerForPreviewingWithDelegate:self sourceView:self.view];
        }
    } else {
        if (self.previewContext) {
            [self unregisterForPreviewingWithContext:self.previewContext];
            self.previewContext = nil;
        }
    }
}

- (BOOL)isForceTouchAvailable {
    BOOL isForceTouchAvailable = NO;
    if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
        isForceTouchAvailable = self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
    }
    return isForceTouchAvailable;
}

#pragma mark - Edit methods

- (IBAction)editButtonClicked:(id)sender {
    [self toggleEditMode];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    if(self.canEdit){
    switch(gesture.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint cellPosition = [gesture locationInView:self.labelCollectionView];
            NSIndexPath *path = [self.labelCollectionView indexPathForItemAtPoint:cellPosition];
            if (path) {
                [self.labelCollectionView beginInteractiveMovementForItemAtIndexPath:path];
            }
            break;

        }
        case UIGestureRecognizerStateChanged:
            [self.labelCollectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.labelCollectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            [self.labelCollectionView endInteractiveMovement];
            [self toggleEditMode];
            break;
        default:
            [self.labelCollectionView cancelInteractiveMovement];
            [self toggleEditMode];
    }
    }
}

-(void)toggleEditMode {
    self.canEdit = !self.canEdit;
    [self.labelCollectionView reloadData];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.canEdit;
}

- (void) collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *temp = self.names[sourceIndexPath.row];
    [self.names removeObjectAtIndex:sourceIndexPath.row];
    [self.names insertObject:temp atIndex:destinationIndexPath.row];
}

- (void) editingValueFinished:(NSString*) value isNewName:(BOOL) isNew {
    [self dismissViewControllerAnimated:YES completion:^{
        if(isNew){
            [self.names addObject:value];
            NSArray * lastIndexpaths = @[[NSIndexPath indexPathForRow:self.names.count-1 inSection:0]];
            [self.labelCollectionView insertItemsAtIndexPaths:lastIndexpaths];
        } else {
            [self.names replaceObjectAtIndex:self.indexPathRow withObject:value];
            [self.labelCollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.indexPathRow inSection:0]]];
        }

    }];
}

#pragma mark - Collectionview methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(width, 50);
}
//
//-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[TIITextFieldViewController class]]) {
        TIITextFieldViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.delegate = self;
      if ([segue.identifier isEqualToString:@"editNameSegue"]){
            destinationViewController.currentName = self.names[self.indexPathRow];
      } else if ([segue.identifier isEqualToString:@"addNameSegue"]) {
        destinationViewController.transitioningDelegate = self.transitionManager;
      }

    } else if ([segue.destinationViewController isKindOfClass:[TIIUIViewController class]]) {
        TIIUIViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.showPosts = YES;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    self.indexPathRow = indexPath.row;
    @try {
       [self performSegueWithIdentifier:@"editNameSegue" sender:self];
    }
    @catch (NSException *exception) {
        NSLog(@"Segue not found: %@", exception);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TIILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nameCell" forIndexPath:indexPath];
    [cell configureWithString:[self.names objectAtIndex:indexPath.row] isEditable:self.canEdit];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.names.count;
}


@end
