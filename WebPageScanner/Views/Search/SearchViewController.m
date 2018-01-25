//
//  SearchViewController.m
//  WebPageScanner
//
//  Created by Egor on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "SearchViewController.h"
#import "ButtonsTableViewCell.h"
#import "SearchEventHandler.h"
#import "SearchViewConfiguration.h"
#import "Constants.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *startURLCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *searchedTextCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *URLLimitCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *threadLimitCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *statusCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *progressCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *textMatchesCell;

@property (weak, nonatomic) IBOutlet ButtonsTableViewCell *buttonsCell;
@property (weak, nonatomic) IBOutlet UIProgressView *searchProgressView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.eventHandler configureView];
    [self configureButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:kProgressCellIdentifier]) {
        [self.eventHandler openProgressScreen];
    }
}


#pragma mark - SearchViewControllerViewing

- (void)updateWithViewConfiguration:(SearchViewConfiguration *)configuration {
    self.startURLCell.detailTextLabel.text = configuration.startURL.absoluteString;
    self.searchedTextCell.detailTextLabel.text = configuration.searchText;
    self.URLLimitCell.detailTextLabel.text = [NSString stringWithFormat:@"%d",
                                              (int)configuration.maxPagesNumber];
    self.threadLimitCell.detailTextLabel.text = [NSString stringWithFormat:@"%d",
                                                 (int)configuration.threadNumber];
    
    self.statusCell.detailTextLabel.text = configuration.viewState;
    self.progressCell.detailTextLabel.text = [NSString stringWithFormat:@"%d / %d",
                                              (int)configuration.loadedPagesNumber,
                                              (int)configuration.maxPagesNumber];
    
    self.textMatchesCell.detailTextLabel.text = [NSString stringWithFormat:@"%d",
                                                 (int)configuration.textMatches];
    
    CGFloat progress = (CGFloat)configuration.loadedPagesNumber /
                        (CGFloat)configuration.maxPagesNumber;
    [self.searchProgressView setProgress:progress animated:true];
}

- (void)showViewController:(__kindof UIViewController *)controller {
    [self.navigationController showViewController:controller sender:self];
}


#pragma mark - Buttons handling

- (void)configureButtons {
    self.buttonsCell.actionHandler = ^(SearchButtonActionType actionType) {
        switch (actionType) {
            case SearchButtonActionTypeStart:
                [self.eventHandler startSearching];
                break;
            case SearchButtonActionTypePause:
                [self.eventHandler pauseSearching];
                break;
            case SearchButtonActionTypeStop:
                [self.eventHandler stopSearching];
                break;
            default:
                break;
        }
    };
}

@end
