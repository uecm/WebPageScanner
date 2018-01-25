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

@interface ProgressEventHandler() <SearchServiceDelegate>

@end

@implementation ProgressEventHandler


#pragma mark - Search Service Delegate


- (void)searchService:(SearchService *)service didFinishSearchingWithResult:(SearchResult *)result {

}

- (void)searchService:(SearchService *)service didUpdateNumberOfMatches:(NSInteger)matches {

}

- (void)searchService:(SearchService *)service didUpdateStatusOfSearchObject:(SearchObject *)object {
    [self.view updateViewWithSearchObject:object];
}

- (void)searchServiceDidForceStopSearching:(SearchService *)service {
    
}


#pragma mark - ProgressViewEventHandling

- (void)configureView {

    NSArray *initialDataSource = [self.searchService usedSearchObjects];
    [self.view updateViewWithDataSource:initialDataSource];
    [self.searchService addDelegate:self];
}

@end
