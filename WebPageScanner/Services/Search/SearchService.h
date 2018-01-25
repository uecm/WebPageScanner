//
//  SearchService.h
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchService;
@class SearchResult;
@class SearchObject;
@class URLLoader;
@class Parser;

@protocol SearchServiceDelegate <NSObject>

@required

- (void)searchService:(SearchService *)service
    didUpdateStatusOfSearchObject:(SearchObject *)object;

- (void)searchService:(SearchService *)service
    didFinishSearchingWithResult:(SearchResult *)result;

- (void)searchService:(SearchService *)service
    didUpdateNumberOfMatches:(NSInteger)matches;

- (void)searchServiceDidForceStopSearching:(SearchService *)service;

@end


@interface SearchService : NSObject

@property (assign, nonatomic) NSInteger maximumURLCount;

- (void)addDelegate:(id<SearchServiceDelegate>)delegate;
- (void)removeDelegate:(id<SearchServiceDelegate>)delegate;

- (instancetype)initWithLoader:(URLLoader *)loader parser:(Parser *)parser NS_DESIGNATED_INITIALIZER;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

- (void)searchText:(NSString *)text startingFromURL:(NSURL *)URL;
- (void)pauseSearch;
- (void)resumeSearch;
- (void)stopSearch;

- (NSArray<SearchObject *> *)usedSearchObjects;

@end
