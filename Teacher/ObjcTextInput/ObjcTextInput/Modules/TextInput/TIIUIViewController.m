//
//  TIIUIViewController.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"
#import "TIILabelCollectionViewCell.h"
#import "Post+Post_Service.h"

@import Faro;

@interface TIIUIViewController () <EditingValueFinishedDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *labelCollectionView;
@property (strong, nonatomic) NSMutableArray *names;
@property (assign, nonatomic) NSInteger indexPathRow;
@property (nonatomic, strong) PostService * service;

@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // const testing
    [self testConst];

    // Post or names
    self.service = [[PostService alloc] init];

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

- (void) testConst {

    int value = 10;
    int value2 = 20;

    int * pointer = &value;
    int * pointer2 = &value2;

    NSLog(@"value  = %i", value);
    NSLog(@"pointer  = %p", pointer);
    NSLog(@"pointer value  = %i", *pointer);

    NSLog(@"value 2  = %i", value2);
    NSLog(@"pointer 2  = %p", pointer2);
    NSLog(@"pointer 2 value  = %i", *pointer2);

    // constant_pointer_to_mutable_int
    int * const constPointer = &value;

    NSLog(@"A - %i", *constPointer);
    *constPointer = value2;
    NSLog(@"B - %i", *constPointer);

//    constPointer = pointer2; // does not compile

    // mutable_pointer_to_constant_int;
    value = 10;
    int const * constValue = &value;

    NSLog(@"C - %i", *constValue);
    constValue = pointer2;
    NSLog(@"D - %i", *constValue);

//    *constValue = value2; // does not compile

    // constant_pointer_to_constant_int;
    int const * const constValueAndPointer = &value;

    NSLog(@"E - %i", *constValueAndPointer);
    // constValueAndPointer = pointer2; // does not compile
    NSLog(@"F - %i", *constValueAndPointer);

    // *constValueAndPointer = value2; // does not compile



    // GLobals

    NSLog(@"%p", global);
    NSLog(@"%i", globalValue);

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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[TIITextFieldViewController class]]) {
        TIITextFieldViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.editingDelegate = self;
        destinationViewController.transitioningDelegate = self;
      if ([segue.identifier isEqualToString:@"editNameSegue"]){
            destinationViewController.currentName = self.names[self.indexPathRow];
        }

    } else if ([segue.destinationViewController isKindOfClass:[TIIUIViewController class]]) {
        TIIUIViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.showPosts = YES;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    self.indexPathRow = indexPath.row;
    [self performSegueWithIdentifier:@"editNameSegue" sender:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TIILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nameCell" forIndexPath:indexPath];
    [cell configureWithString:[self.names objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.names.count;
}

#pragma mark: - UIViewControllerTransitioningDelegate

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[GenieAnimator alloc] init];
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[GenieAnimator alloc] init];
}


@end
