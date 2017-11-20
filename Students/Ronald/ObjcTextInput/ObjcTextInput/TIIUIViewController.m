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

@interface TIIUIViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *labelCollectionView;
@property (strong, nonatomic) NSMutableArray *names;
@property (assign, nonatomic) NSInteger indexPathRow;
@property UILongPressGestureRecognizer *longPress;
@property (nonatomic) BOOL isEditable;
@property BOOL presenting;

@property (nonatomic, strong) id previewingContext;

@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = [@[@"Ronald",@"Charlotte",@"Stijn"] mutableCopy];
    self.longPress = [[UILongPressGestureRecognizer alloc]
                         initWithTarget:self
                         action:@selector(handleLongPress:)];
    [self.labelCollectionView addGestureRecognizer:self.longPress];
    self.isEditable = NO;
    TIISlideInCollectionViewLayout * layout = (TIISlideInCollectionViewLayout*) self.labelCollectionView.collectionViewLayout;
    layout.translation = [[Translation alloc] initWithX:300 y:0];
    
    if ([self isForceTouchAvailable]) {
        self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.labelCollectionView];
    }
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(width, 50);
}

- (IBAction)goToEdit:(id)sender {
    [self performSegueWithIdentifier:@"addNameSegue" sender:self];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[TIITextFieldViewController class]]) {
        TIITextFieldViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.delegate = self;
      if ([segue.identifier isEqualToString:@"editNameSegue"]){
            destinationViewController.currentName = self.names[self.indexPathRow];
      } else if ([segue.identifier isEqualToString:@"addNameSegue"]) {
          
          destinationViewController.transitioningDelegate = self;
      }
    }
}

- (IBAction)editTableView:(UIBarButtonItem *)sender {
    self.isEditable = !self.isEditable;
    [self.labelCollectionView reloadData];
}

// MARK: - Collection View Datasource

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    self.indexPathRow = indexPath.row;
    [self performSegueWithIdentifier:@"editNameSegue" sender:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TIILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nameCell" forIndexPath:indexPath];
    [cell configureWithString:[self.names objectAtIndex:indexPath.row] andDragHandler:self.isEditable];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.names.count;
}

#pragma mark - Collection View Delegate

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEditable) {
        return YES;
    } else {
        return NO;
    }
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString * selectedItem = [self.names objectAtIndex:sourceIndexPath.row];
    [self.names removeObjectAtIndex:sourceIndexPath.row];
    [self.names insertObject:selectedItem atIndex:destinationIndexPath.row];
  
    for (NSString * name in self.names) {
        NSLog(@"Array: %@",name);
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer*)sender{
    switch(sender.state) {
        case UIGestureRecognizerStateBegan:{
            CGPoint selectedPoint = [sender locationInView: self.labelCollectionView];
            NSIndexPath * selectedIndexPath = [self.labelCollectionView indexPathForItemAtPoint:selectedPoint];
            [self.labelCollectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
        }
        case UIGestureRecognizerStateChanged:
            [self.labelCollectionView updateInteractiveMovementTargetPosition:[sender locationInView: self.labelCollectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            [self.labelCollectionView endInteractiveMovement];
            break;
        default:
            [self.labelCollectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - Peek and Pop

- (BOOL)isForceTouchAvailable {
    BOOL isForceTouchAvailable = NO;
    if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
        isForceTouchAvailable = self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
    }
    return isForceTouchAvailable;
}

- (void)previewingContext:(nonnull id<UIViewControllerPreviewing>)previewingContext commitViewController:(nonnull UIViewController *)viewControllerToCommit {
    [self presentViewController:viewControllerToCommit animated:YES completion:nil];
}

- (nullable UIViewController *)previewingContext:(nonnull id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    // check if we're not already displaying a preview controller
    if ([self.presentedViewController isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    
    NSIndexPath * selectedIndexPath = [self.labelCollectionView indexPathForItemAtPoint:location];
    
    if (selectedIndexPath) {
        UICollectionViewCell *cell = [self.labelCollectionView cellForItemAtIndexPath:selectedIndexPath];
        
        // get your UIStoryboard
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TextField" bundle:nil];
        
        // set the view controller by initializing it form the storyboard
        TIITextFieldViewController *previewController = [storyboard instantiateViewControllerWithIdentifier:@"TIITextFieldViewController"];
    
        previewController.currentName = [self.names objectAtIndex:selectedIndexPath.row];
        previewController.delegate = self;
        self.indexPathRow = selectedIndexPath.row;
        previewingContext.sourceRect = cell.frame;
        return previewController;
    }
    return nil;
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if ([self isForceTouchAvailable]) {
        if (!self.previewingContext) {
            self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.labelCollectionView];
        }
    } else {
        if (self.previewingContext) {
            [self unregisterForPreviewingWithContext:self.previewingContext];
            self.previewingContext = nil;
        }
    }
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    // get reference to our fromView, toView and the container view that we should perform the transition in
    
    UIView * container = transitionContext.containerView;
    
    UIView * fromView =[transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    CGAffineTransform offScreenRight = CGAffineTransformMakeTranslation(container.frame.size.width, 0);
    CGAffineTransform offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.size.width, 0);

    if (self.presenting) {
        toView.transform = offScreenRight;
    } else {
        toView.transform = offScreenLeft;
    }
    
    // add the both views to our view controller
    [container addSubview:toView];
    [container addSubview:fromView];
    
    // get the duration of the animation
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // perform the animation!
    // for this example, just slid both fromView and toView to the left at the same time
    // meaning fromView is pushed off the screen and toView slides into view
    // we also use the block animation usingSpringWithDamping for a little bounce
    
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:0 animations:^{
        if (self.presenting) {
            fromView.transform = offScreenLeft;
        } else {
            fromView.transform = offScreenRight;
        }

        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presenting = YES;
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return self;
}

@end
