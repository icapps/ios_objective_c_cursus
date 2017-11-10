//
//  TIIUIViewController.m
//  ObjcTextInput
//
//  Created by Naomi De Leeuw on 09/11/2017.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"
#import "TIILabelCollectionViewCell.h"

@interface TIIUIViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *labelCollectionView;
@property (strong, nonatomic) NSMutableArray *names;

@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.names = [@[@"Ronald",@"Charlotte",@"Stijn"] mutableCopy];
    [self.labelCollectionView reloadData];
}

- (void) editingValueFinished:(NSString *)value {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.names addObject:value];
        NSMutableArray *indexpaths = [NSMutableArray array];
        [indexpaths addObject:[NSIndexPath indexPathForRow:self.names.count-1 inSection:0]];
        [self.labelCollectionView insertItemsAtIndexPaths:indexpaths];
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[TIITextFieldViewController class]]) {
        TIITextFieldViewController * destinationViewController = segue.destinationViewController;
        destinationViewController.delegate = self;

    }
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
