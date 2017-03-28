//
//  ViewController.m
//  Lesson1
//
//  Created by Stefan Adams on 21/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "Lesson1-Swift.h"

@interface ViewController ()

#pragma mark - IBOutlets

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark - ViewModel

@property (strong, nonatomic) ViewModel* viewModel;

@end

@implementation ViewController

#pragma mark - View Flow

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel = [[ViewModel alloc] initWithService: [[PostService alloc] init]];
    
	__weak ViewController *weakSelf = self;
    self.viewModel.updateHandler = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    };
    
    [self setupTranslations];
}

#pragma mark - Translations

- (void)setupTranslations {
    _titleLabel.text = self.viewModel.titleLabelText;
}
- (IBAction)fetchData:(id)sender {
    [self.viewModel fetchPosts];
}

#pragma mark - TableView (delegates, datasource)

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.viewModel postAtIndexPath:indexPath].title;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfRows;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
