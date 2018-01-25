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

@property (strong, nonatomic) NSArray<SearchObject *> *queue;
@property (strong, nonatomic) NSMutableArray<SearchObject *> *nextLevelQueue;
@property (strong, nonatomic) NSMutableArray<SearchObject *> *usedObjects;

@property (strong, nonatomic) NSMutableArray<NSURL *> *usedURLs;

@property (strong, nonatomic) SearchResult *searchResult;

@end


@implementation SearchService {
    NSHashTable *delegates;
    BOOL paused;
}

- (instancetype)initWithLoader:(URLLoader *)loader parser:(Parser *)parser {
    self = [super init];
    if (self) {
        delegates = [NSHashTable weakObjectsHashTable];

        self.loader = loader;
        self.parser = parser;
        self.searchResult = [[SearchResult alloc] init];
        
        self.queue = [NSMutableArray array];
        self.nextLevelQueue = [NSMutableArray array];
        self.usedURLs = [NSMutableArray array];
        self.usedObjects = [NSMutableArray array];
    }
    return self;
}

- (void)addDelegate:(id<SearchServiceDelegate>)delegate {
    [delegates addObject:delegate];
}

- (void)removeDelegate:(id<SearchServiceDelegate>)delegate {
    [delegates removeObject:delegate];
}


- (NSArray<SearchObject *> *)usedSearchObjects {
    return [self.usedObjects copy];
}


#pragma mark - Network Actions

- (void)searchText:(NSString *)text startingFromURL:(NSURL *)URL {
    if (!self.loader) {
        return;
    }
    paused = false;
    self.searchResult.text = text;
    self.searchResult.startURL = URL;
    
    SearchObject *searchObject = [[SearchObject alloc] initWithURL:URL];
    searchObject.depthLevel = 0;
    self.queue = @[searchObject];

    [self loadCurrentQueueObjects];
}

- (void)pauseSearch {
    paused = true;
    [self.loader pauseLoading];
    
    for (SearchObject *object in self.queue) {
        if (object.status == SearchObjectStatusLoading ||
            object.status == SearchObjectStatusPending) {
            object.status = SearchObjectStatusSuspended;
            for (id delegate in delegates) {
                [delegate searchService:self didUpdateStatusOfSearchObject:object];
            }
        }
    }
}

- (void)resumeSearch {
    paused = false;
    [self.loader resumeLoading];
    for (SearchObject *object in self.queue) {
        if (object.status == SearchObjectStatusSuspended) {
            object.status = SearchObjectStatusPending;
            for (id delegate in delegates) {
                [delegate searchService:self didUpdateStatusOfSearchObject:object];
            }
        }
    }
}

- (void)stopSearch {
    paused = false;
    [self.loader stopLoading];
    self.queue = [NSArray array];
    self.usedURLs = [NSMutableArray array];
    self.usedObjects = [NSMutableArray array];

    for (SearchObject *object in self.queue) {
        if (object.status == SearchObjectStatusLoading ||
            object.status == SearchObjectStatusPending ||
            object.status == SearchObjectStatusSuspended) {
            object.status = SearchObjectStatusCancelled;
            for (id delegate in delegates) {
                [delegate searchService:self didUpdateStatusOfSearchObject:object];
            }
        }
    }
    for (id delegate in delegates) {
        [delegate searchServiceDidForceStopSearching:self];
    }
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
                for (id delegate in delegates) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [delegate searchService:self didFinishSearchingWithResult:self.searchResult];
                    });
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
        for (id delegate in delegates) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate searchService:self didFinishSearchingWithResult:self.searchResult];
            });
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
    if (self.usedURLs.count == self.maximumURLCount) {
        return;
    }
    searchObject.status = SearchObjectStatusLoading;
    for (id delegate in delegates) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate searchService:self didUpdateStatusOfSearchObject:searchObject];
        });
    }
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.loader loadURL:searchObject.URL withCompletion:^(URLResponse *response, NSError *error) {
        [self.usedURLs addObject:searchObject.URL];
        if ((self.usedURLs.count > self.maximumURLCount) || paused) {
            return;
        }
        if (error != nil) {
            searchObject.status = SearchObjectStatusNetworkError;
            searchObject.statusDescription = response.contents;

            self.searchResult.totalErrors += 1;
        } else {
            searchObject.status = SearchObjectStatusSuccess;
            if (weakSelf != nil) {
                [weakSelf handleResponseHTML:response.contents
                              withSearchText:weakSelf.searchResult.text
                             forSearchObject:searchObject];
            }
        }
        for (id delegate in delegates) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.usedObjects addObject:searchObject];
                [delegate searchService:self didUpdateStatusOfSearchObject:searchObject];
            });
        }
        if (self.usedURLs.count == self.maximumURLCount) {
            completion(true);
        } else {
            completion(false);
        }
    }];
    if (self.usedURLs.count == self.maximumURLCount) {
        completion(true);
    }
}




#pragma mark - Search Actions

- (void)handleResponseHTML:(NSString *)htmlString
            withSearchText:(NSString *)text
           forSearchObject:(SearchObject *)searchObject {
    
    if (!htmlString) {
        return;
    }
    NSInteger numberOfMatches = [self.parser numberOfMatchesForText:text
                                                   inContentsOfPage:htmlString];
    NSArray<NSString *> *links = [self.parser linksInContentsOfPage:htmlString];
    
    searchObject.textMatches = numberOfMatches;
    for (id delegate in delegates) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate searchService:self didUpdateNumberOfMatches:numberOfMatches];
        });
    }
    
    
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
            object.status = SearchObjectStatusPending;
            object.depthLevel = parentObject.depthLevel + 1;
            [searchObjects addObject:object];
        }
    }
    return [searchObjects copy];
}




@end
