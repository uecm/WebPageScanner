//
//  ProgressViewController.m
//  WebPageScanner
//
//  Created by Greg on 1/25/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "ProgressViewController.h"
#import "ProgressEventHandler.h"
#import "Constants.h"
#import "SearchObject.h"
#import "AlertController.h"

@interface ProgressViewController ()

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.eventHandler configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.eventHandler dataSource].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProgressViewCellIdentifier
                                                            forIndexPath:indexPath];
    
    SearchObject *object = [[self.eventHandler dataSource] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = object.URL.absoluteString;
    cell.detailTextLabel.text = object.statusDescription;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
    accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self.eventHandler showDetailForItemAtIndex:indexPath.row];
}


#pragma mark - ProgressViewControllerViewing

- (void)configureTableView {
    [self.tableView reloadData];
}

- (void)updateItemAtIndex:(NSInteger)index withActionType:(ItemUpdateActionType)actionType {
    [self.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    switch (actionType) {
        case ItemUpdateActionTypeAdd:
            [self.tableView insertRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationNone];
            break;
        case ItemUpdateActionTypeReload:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationNone];
            break;
        default:
            break;
    }
    [self.tableView endUpdates];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    AlertController *alert = [AlertController alertWithTitle:title
                                                     message:message
                                                 buttonTitle:kAlertOkButton];
    [self presentViewController:alert animated:true completion:nil];
}



@end
