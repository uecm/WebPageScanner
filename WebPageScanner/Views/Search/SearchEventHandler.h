//
//  SearchEventHandler.h
//  WebPageScanner
//
//  Created by Egor on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchService;
@class SearchConfiguration;
@protocol SearchViewControllerViewing;

@protocol SearchViewControllerEventHandling <NSObject>
@required
- (void)configureView;

- (void)startSearching;
- (void)pauseSearching;
- (void)stopSearching;

@end

@interface SearchEventHandler : NSObject <SearchViewControllerEventHandling>

@property (strong, nonatomic) SearchService *searchService;
@property (weak, nonatomic) id<SearchViewControllerViewing> view;

- (instancetype)initWithConfiguration:(SearchConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

@end
