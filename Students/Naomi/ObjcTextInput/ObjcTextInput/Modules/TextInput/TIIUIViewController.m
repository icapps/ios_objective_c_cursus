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

@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.service = [[PostService alloc] init];

    if (!self.showPosts) {
        self.names = [@[@"Ronald",@"Charlotte",@"Stijn"] mutableCopy];
    } else {
        __weak TIIUIViewController * weakSelf = self;
        [self.service getPosts:^{
            NSArray <Post *>* posts = weakSelf.service.posts;
            NSMutableArray <NSString *> *mapped = [NSMutableArray arrayWithCapacity:[posts count]];
            [posts enumerateObjectsUsingBlock:^(Post * post, NSUInteger idx, BOOL *stop) {
//                NSString * string = [NSString stringWithFormat:@"%@", ];
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
        destinationViewController.delegate = self;
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
    @try {
       [self performSegueWithIdentifier:@"editNameSegue" sender:self];
    }
    @catch (NSException *exception) {
        NSLog(@"Segue not found: %@", exception);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TIILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nameCell" forIndexPath:indexPath];
    [cell configureWithString:[self.names objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.names.count;
}


@end
