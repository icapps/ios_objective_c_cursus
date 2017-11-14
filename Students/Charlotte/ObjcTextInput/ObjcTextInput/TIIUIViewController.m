//
//  TIIUIViewController.m
//  ObjcTextInput
//
//  Created by Charlotte Erpels on 9/11/17.
//  Copyright © 2017 iCapps. All rights reserved.
//

#import "TIIUIViewController.h"
#import "TIIChangeTextViewController.h"
#import "LabelCollectionViewCell.h"

@interface TIIUIViewController () <UICollectionViewDataSource,UICollectionViewDelegate,TextDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray <NSString *> * textArray;
@property (nonatomic, assign) NSUInteger selectedItemIndex;
@end

@implementation TIIUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textArray = [[NSMutableArray alloc] init];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.textArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"LabelCell";
    
    LabelCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString * cellText = [self.textArray objectAtIndex:indexPath.row];
    [cell configureWithString:cellText];
    return cell;
}

#pragma mark - UICollectionViewDataSource

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    self.selectedItemIndex = indexPath.item;
}

#pragma mark - TextDelegate

-(void)didAddText:(NSString *)newText {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.textArray addObject:newText];
        [self.collectionView reloadData];
    }];
}

-(void)didEditText:(NSString *)editedText :(NSIndexPath *)itemIndex {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.textArray replaceObjectAtIndex:itemIndex.row withObject:editedText];
        [self.collectionView reloadData];
    }];
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
            //controller.itemIndex = self.selectedItemIndex;
            controller.itemIndex = [[self.collectionView indexPathsForSelectedItems] firstObject];
        }
    }
}

@end
