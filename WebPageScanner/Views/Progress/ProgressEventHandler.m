//
//  ProgressEventHandler.m
//  WebPageScanner
//
//  Created by Greg on 1/25/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "ProgressEventHandler.h"
#import "ProgressViewController.h"
#import "SearchService.h"
#import "SearchObject.h"
#import "Constants.h"


@interface ProgressEventHandler() <SearchServiceDelegate>

@property (strong, nonatomic) NSMutableArray<SearchObject *> *data;

@end

@implementation ProgressEventHandler


#pragma mark - Search Service Delegate


- (void)searchService:(SearchService *)service didFinishSearchingWithResult:(SearchResult *)result {

}

- (void)searchService:(SearchService *)service didUpdateNumberOfMatches:(NSInteger)matches {

}

- (void)searchService:(SearchService *)service didUpdateStatusOfSearchObject:(SearchObject *)object {
    ItemUpdateActionType actionType = ItemUpdateActionTypeReload;
    if (![self.data containsObject:object]) {
        [self.data addObject:object];
        actionType = ItemUpdateActionTypeAdd;
    }
    NSInteger index = [self.data indexOfObject:object];
    [self.view updateItemAtIndex:index withActionType:actionType];
}

- (void)searchServiceDidForceStopSearching:(SearchService *)service {
    
}


#pragma mark - ProgressViewEventHandling

- (void)configureView {
    self.data = [NSMutableArray arrayWithArray:[self.searchService usedSearchObjects]];
    [self.view configureTableView];
    [self.searchService addDelegate:self];
}

- (NSArray<SearchObject *> *)dataSource {
    return [self.data copy];
}

- (void)showDetailForItemAtIndex:(NSInteger)index {
    SearchObject *object = [self.data objectAtIndex:index];
    if (object) {
        NSString *title = object.statusDescription;
        NSString *message;
        switch (object.status) {
            case SearchObjectStatusSuccess:
                message = [NSString stringWithFormat:kSuccessSearchObjectMessage,
                            object.textMatches];
                break;
            case SearchObjectStatusNetworkError:
                message = object.info;
            default:
                break;
        }
        [self.view showAlertWithTitle:title message:message];
    }
}


@end
