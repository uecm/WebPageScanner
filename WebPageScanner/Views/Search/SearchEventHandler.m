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
#import "FlowController.h"

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

    if (self.viewState == SearchViewStatePaused) { // Resume
        [self.searchService resumeSearch];
        self.viewState = SearchViewStateLoading;
        [self configureView];
        return;
    }

    // Initial search
    [self.searchService addDelegate:self];
    self.searchService.maximumURLCount = self.viewConfiguration.maxPagesNumber;
    [self.searchService searchText:self.viewConfiguration.searchText
                   startingFromURL:self.viewConfiguration.startURL];
    
    self.viewState = SearchViewStateLoading;
    [self configureView];
}

- (void)pauseSearching {
    self.viewState = SearchViewStatePaused;
    [self configureView];

    [self.searchService pauseSearch];
}

- (void)stopSearching {
    self.viewState = SearchViewStateIdle;
    [self configureView];
    [self.searchService stopSearch];
}

- (void)openProgressScreen {
    ProgressViewController *progressViewController = [self.flowController initializeProgressViewControllerWithSearchService:self.searchService];
    [self.view showViewController:(UIViewController *)progressViewController];
}

#pragma mark - Search Service Delegate

- (void)searchService:(SearchService *)service didFinishSearchingWithResult:(SearchResult *)result {
    self.viewState = SearchViewStateIdle;
    [self configureView];
}

- (void)searchService:(SearchService *)service didUpdateStatusOfSearchObject:(SearchObject *)object {
    if (self.viewState == SearchViewStateIdle) {
        return;
    }

    if (object.status == SearchObjectStatusSuccess ||
        object.status == SearchObjectStatusNetworkError) {
        self.viewConfiguration.loadedPagesNumber += 1;
        [self.view updateWithViewConfiguration:self.viewConfiguration];
    }
}

- (void)searchService:(SearchService *)service didUpdateNumberOfMatches:(NSInteger)matches {
    if (self.viewState == SearchViewStateLoading) {
        self.viewConfiguration.textMatches += matches;
        [self.view updateWithViewConfiguration:self.viewConfiguration];
    }
}

- (void)searchServiceDidForceStopSearching:(SearchService *)service {
    self.viewConfiguration.loadedPagesNumber = 0;
    self.viewConfiguration.textMatches = 0;
    [self configureView];
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
