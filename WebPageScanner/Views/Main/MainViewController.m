//
//  ViewController.m
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "MainViewController.h"
#import "MainEventHandler.h"
#import "TextFieldTableViewCell.h"
#import "AlertController.h"
#import "Constants.h"
#import "FlowController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet TextFieldTableViewCell *URLCell;
@property (weak, nonatomic) IBOutlet TextFieldTableViewCell *searchTextCell;
@property (weak, nonatomic) IBOutlet TextFieldTableViewCell *threadsCell;
@property (weak, nonatomic) IBOutlet TextFieldTableViewCell *pagesCell;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - MainViewControllerViewing

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    AlertController *alert = [AlertController alertWithTitle:title
                                                     message:message
                                                 buttonTitle:kAlertOkButton];
    [self presentViewController:alert animated:true completion:nil];
}

- (void)showViewController:(__kindof UIViewController *)controller {
    [self.navigationController showViewController:controller sender:self];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[TextFieldTableViewCell class]]) {
        [((TextFieldTableViewCell *)cell) becomeFirstResponder];
    } else if ([cell.reuseIdentifier isEqualToString:kSearchCellIdentifier]) {
        [self.eventHandler showSearchScreen];
    }
}

#pragma mark - Misc

- (void)configureView {
    [self addTapOutsideGesture];
    
    self.URLCell.nextCell = self.searchTextCell;
    self.URLCell.returnHandler = ^(NSString *text) {
        [self.eventHandler setURLWithString:text];
    };
    
    self.searchTextCell.nextCell = self.threadsCell;
    self.searchTextCell.returnHandler = ^(NSString *text) {
        [self.eventHandler setSearchText:text];
    };
    
    self.threadsCell.nextCell = self.pagesCell;
    self.threadsCell.returnHandler = ^(NSString *text) {
        [self.eventHandler setThreadNumber:text.integerValue];
    };
    
    self.pagesCell.returnHandler = ^(NSString *text) {
        [self.eventHandler setPageNumber:text.integerValue];
    };
}


- (void)addTapOutsideGesture {
    UITapGestureRecognizer *tapOutsideRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(tapOutsideHandler:)];
    tapOutsideRecognizer.cancelsTouchesInView = false;
    [self.tableView addGestureRecognizer:tapOutsideRecognizer];
}

- (void)tapOutsideHandler:(UITapGestureRecognizer *)recognizer {
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:
                              [recognizer locationInView:self.tableView]];
    if (indexPath) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[TextFieldTableViewCell class]]) {
            return;
        }
    }
    [self.view endEditing:NO];
}

@end
