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

@optional
- (void)searchServiceDidFailSearch:(SearchService *)service;

@end


@interface SearchService : NSObject

@property (assign, nonatomic) NSInteger maximumURLCount;
@property (weak, nonatomic) id<SearchServiceDelegate> delegate;


- (instancetype)initWithLoader:(URLLoader *)loader parser:(Parser *)parser;

- (void)searchText:(NSString *)text startingFromURL:(NSURL *)URL;
- (void)pauseSearch;
- (void)stopSearch;


@end
