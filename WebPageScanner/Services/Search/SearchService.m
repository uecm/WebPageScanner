//
//  SearchService.m
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "SearchService.h"
#import "SearchObject.h"
#import "SearchResult.h"
#import "URLLoader.h"
#import "URLResponse.h"
#import "Parser.h"
#import "Constants.h"


typedef NS_ENUM(NSInteger, SearchServiceFinishReason) {
    SearchServiceFinishReasonReachedMaxAmount,
    SearchServiceFinishReasonFinishedQueue
};


@interface SearchService()

@property (strong, nonatomic) URLLoader *loader;
@property (strong, nonatomic) Parser *parser;

@property (strong, nonatomic) NSMutableArray<SearchObject *> *queue;
@property (strong, nonatomic) NSMutableArray<SearchObject *> *nextLevelQueue;

@property (strong, nonatomic) NSMutableArray<NSURL *> *usedURLs;

@property (strong, nonatomic) SearchResult *searchResult;

@end


@implementation SearchService

- (instancetype)initWithLoader:(URLLoader *)loader parser:(Parser *)parser {
    self = [super init];
    if (self) {
        self.loader = loader;
        self.parser = parser;
        self.searchResult = [[SearchResult alloc] init];
        
        self.queue = [[NSMutableArray alloc] init];
        self.nextLevelQueue = [[NSMutableArray alloc] init];
        self.usedURLs = [[NSMutableArray alloc] init];
    }
    return self;
}


#pragma mark - Network Actions

- (void)searchText:(NSString *)text startingFromURL:(NSURL *)URL {
    if (!self.loader) {
        return;
    }
    
    self.searchResult.text = text;
    self.searchResult.startURL = URL;
    
    SearchObject *searchObject = [[SearchObject alloc] initWithURL:URL];
    searchObject.depthLevel = 0;
    [self.queue addObject:searchObject];

    [self loadCurrentQueueObjects];
}

- (void)pauseSearch {
    
}

- (void)stopSearch {
    
}





#pragma mark Private


- (void)loadCurrentQueueObjects {
    [self loadCurrentQueueWithCompletion:^(SearchServiceFinishReason reason) {
        switch (reason) {
            case SearchServiceFinishReasonFinishedQueue:
                self.queue = [self.nextLevelQueue copy];
                [self loadCurrentQueueObjects];
                break;
            case SearchServiceFinishReasonReachedMaxAmount:
                if ([self.delegate respondsToSelector:@selector(searchService:didFinishSearchingWithResult:)]) {
                    [self.delegate searchService:self didFinishSearchingWithResult:self.searchResult];
                }
                break;
            default:
                break;
        }
    }];
}


- (void)loadCurrentQueueWithCompletion:(void (^)(SearchServiceFinishReason reason))completion {
    __block NSInteger counter = self.queue.count;

    if (self.queue.count == 0) {
        if ([self.delegate respondsToSelector:@selector(searchService:didFinishSearchingWithResult:)]) {
            [self.delegate searchService:self didFinishSearchingWithResult:self.searchResult];
        }
        return;
    }

    for (SearchObject *object in self.queue) {
        [self loadURLOfSearchObject:object withCompletion:^(BOOL shouldStopLoading) {
            if (shouldStopLoading) {
                completion(SearchServiceFinishReasonReachedMaxAmount);
                return;
            }
            counter -= 1;
            if (counter == 0) {
                completion(SearchServiceFinishReasonFinishedQueue);
            }
        }];
    }
}


- (void)loadURLOfSearchObject:(SearchObject *)searchObject
               withCompletion:(void (^)(BOOL success))completion {

    [self.usedURLs addObject:searchObject.URL];

    searchObject.status = SearchObjectStatusLoading;

    __unsafe_unretained typeof(self) weakSelf = self;
    [self.loader loadURL:searchObject.URL withCompletion:^(URLResponse *response, NSError *error) {
        if (error != nil) {
            searchObject.status = SearchObjectStatusNetworkError;
            searchObject.statusDescription = response.contents;
            
        } else {
            searchObject.status = SearchObjectStatusSuccess;
            if (weakSelf != nil) {
                [weakSelf handleResponseHTML:response.contents
                              withSearchText:weakSelf.searchResult.text
                             forSearchObject:searchObject];
            }
        }
        completion(false);
    }];

    if (self.usedURLs.count == self.maximumURLCount) {
        completion(true);
    }
}




#pragma mark - Search Actions

- (void)handleResponseHTML:(NSString *)htmlString
            withSearchText:(NSString *)text
           forSearchObject:(SearchObject *)searchObject {
    
    NSInteger numberOfMatches = [self.parser numberOfMatchesForText:text
                                                   inContentsOfPage:htmlString];
    NSArray<NSString *> *links = [self.parser linksInContentsOfPage:htmlString];
    
    self.searchResult.totalTextMatches += numberOfMatches;
    
    NSArray<SearchObject *> *searchObjects = [self searchObjectsForLinks:links
                                                              withParent:searchObject];
    [self.nextLevelQueue addObjectsFromArray:searchObjects];
    
}


- (NSArray<SearchObject *> *)searchObjectsForLinks:(NSArray<NSString *> *)links
                                        withParent:(SearchObject *)parentObject {
    NSMutableArray<SearchObject *> *searchObjects = [[NSMutableArray alloc] init];
    for (NSString *link in links) {
        NSURL *URL = [NSURL URLWithString:link];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:kURLAbsoluteStringMatchPredicate,
                                    URL.absoluteString];
        BOOL isUsed = [self.usedURLs filteredArrayUsingPredicate:predicate].count > 0;
        if (!isUsed) {
            SearchObject *object = [[SearchObject alloc] initWithURL:URL];
            object.depthLevel = parentObject.depthLevel + 1;
            [searchObjects addObject:object];
        }
    }
    return [searchObjects copy];
}




@end
