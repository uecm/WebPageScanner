//
//  SearchEventHandler.m
//  WebPageScanner
//
//  Created by Egor on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "SearchEventHandler.h"
#import "SearchViewController.h"
#import "SearchViewConfiguration.h"
#import "Constants.h"
#import "SearchService.h"
#import "SearchObject.h"

typedef NS_ENUM(NSInteger, SearchViewState) {
    SearchViewStateLoading,
    SearchViewStatePaused,
    SearchViewStateIdle
};


@interface SearchEventHandler() <SearchServiceDelegate>

@property (strong, nonatomic) SearchViewConfiguration *viewConfiguration;
@property (assign, nonatomic) SearchViewState viewState;

@end

@implementation SearchEventHandler

- (instancetype)initWithConfiguration:(SearchConfiguration *)configuration {
    self = [super init];
    if (self) {
        self.viewState = SearchViewStateIdle;
        self.viewConfiguration = [[SearchViewConfiguration alloc]
                                    initWithSearchConfiguration:configuration];
    }
    return self;
}


#pragma mark - SearchViewControllerEventHandling

- (void)configureView {
    
    self.viewConfiguration.viewState = [self descriptionForViewState];
    
    
    [self.view updateWithViewConfiguration:self.viewConfiguration];
}


- (void)startSearching {
    self.searchService.delegate = self;
    self.searchService.maximumURLCount = self.viewConfiguration.maxPagesNumber;
    [self.searchService searchText:self.viewConfiguration.searchText
                   startingFromURL:self.viewConfiguration.startURL];
    
    self.viewState = SearchViewStateLoading;
    self.viewConfiguration.viewState = [self descriptionForViewState];
    [self.view updateWithViewConfiguration:self.viewConfiguration];
}

- (void)pauseSearching {
    [self.searchService pauseSearch];
}

- (void)stopSearching {
    [self.searchService stopSearch];
}


#pragma mark - Search Service Delegate

- (void)searchService:(SearchService *)service didFinishSearchingWithResult:(SearchResult *)result {
    self.viewState = SearchViewStateIdle;
    self.viewConfiguration.viewState = [self descriptionForViewState];
    [self.view updateWithViewConfiguration:self.viewConfiguration];
}

- (void)searchService:(SearchService *)service didUpdateStatusOfSearchObject:(SearchObject *)object {
    if (object.status == SearchObjectStatusSuccess ||
        object.status == SearchObjectStatusNetworkError) {
        self.viewConfiguration.loadedPagesNumber += 1;
        [self.view updateWithViewConfiguration:self.viewConfiguration];
    }
}

- (void)searchService:(SearchService *)service didUpdateNumberOfMatches:(NSInteger)matches {
    self.viewConfiguration.textMatches += matches;
    [self.view updateWithViewConfiguration:self.viewConfiguration];
}

- (void)searchServiceDidStopSearching:(SearchService *)service {
    self.viewConfiguration.loadedPagesNumber = 0;
    self.viewConfiguration.textMatches = 0;
}

- (void)searchServiceDidFailSearch:(SearchService *)service {
    
}



#pragma mark - Private

- (NSString *)descriptionForViewState {
    NSString *statusText;
    switch (self.viewState) {
        case SearchViewStateIdle:
            statusText = kViewStateIdle;
            break;
        case SearchViewStatePaused:
            statusText = kViewStatePaused;
            break;
        case SearchViewStateLoading:
            statusText = kViewStateLoading;
            break;
        default:
            break;
    }
    return statusText;
}

@end
