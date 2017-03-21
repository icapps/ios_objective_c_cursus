//
//  ViewController.m
//  Lesson1
//
//  Created by Stefan Adams on 21/03/2017.
//  Copyright © 2017 Stefan Adams. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"

@interface ViewController ()

// MARK: - IBOutlets

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

// MARK: - ViewModel

@property (strong, nonatomic) ViewModel* viewModel;

@end

@implementation ViewController

// MARK: - View Flow

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[ViewModel alloc] init];
    [self setupTranslations];
}

// MARK: - Translations

- (void)setupTranslations {
    _titleLabel.text = self.viewModel.titleLabelText;
}

// MARK: - TableView (delegates, datasource)

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.viewModel.ingredients[indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.ingredients.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
