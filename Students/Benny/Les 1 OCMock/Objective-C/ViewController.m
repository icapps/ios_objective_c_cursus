//
//  ViewController.m
//  Objective-C
//
//  Created by Stijn Willems on 21/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property ViewModel *viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    if (self) {
        _viewModel = [[ViewModel alloc] init];
        [self.viewModel load:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"tableViewCell"];
    
    cell.textLabel.text = self.viewModel.post.title;
    
    return cell;
}


@end
