//
//  ProgressViewController.m
//  WebPageScanner
//
//  Created by Greg on 1/25/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "ProgressViewController.h"
#import "ProgressEventHandler.h"

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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}



#pragma mark - ProgressViewControllerViewing

- (void)updateViewWithDataSource:(NSArray<SearchObject *> *)dataSource {

}

- (void)updateViewWithSearchObject:(SearchObject *)searchObject {
    
}


@end
