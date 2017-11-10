//
//  TIIUIViewController.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"
#import "TIILabelCollectionViewCell.h"
#import "MyCustomFlowLayout.h"

const NSInteger rowToInsertNewName = 1;

@interface TIIUIViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *labelCollectionView;
@property (strong, nonatomic) NSMutableArray *names;
@property (assign, nonatomic) NSInteger indexPathRow;

@end

@implementation TIIUIViewController

// MARK: - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = [@[@"Ronald",@"Charlotte",@"Stijn"] mutableCopy];
    MyCustomFlowLayout *layout = [[MyCustomFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(375, 50);
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[TIITextFieldViewController class]]) {
        TIITextFieldViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.delegate = self;
        if ([segue.identifier isEqualToString:@"editNameSegue"]){
            destinationViewController.currentName = self.names[self.indexPathRow];
        }
        
    }
}

// MARK: - EditingValueFinishedDelegate

- (void) editingValueFinished:(NSString*) value isNewName:(BOOL) isNew {
    [self dismissViewControllerAnimated:YES completion:^{
        if(isNew){
            [self.names insertObject:value atIndex:rowToInsertNewName];
            NSMutableArray *indexpaths = [NSMutableArray array];
            [indexpaths addObject:[NSIndexPath indexPathForRow:rowToInsertNewName inSection:0]];
            [self.labelCollectionView insertItemsAtIndexPaths:indexpaths];
        } else {
            [self.names replaceObjectAtIndex:self.indexPathRow withObject:value];
            [self.labelCollectionView reloadData];
            NSLog(@"%@", value);
        }

    }];
}

// MARK: - CollectionView

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    self.indexPathRow = indexPath.row;
    [self performSegueWithIdentifier:@"editNameSegue" sender:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TIILabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nameCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.names objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.names.count;
}

@end
