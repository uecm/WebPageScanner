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
@class FlowController;
@protocol SearchViewControllerViewing;

@protocol SearchViewControllerEventHandling <NSObject>
@required
- (void)configureView;

- (void)startSearching;
- (void)pauseSearching;
- (void)stopSearching;

- (void)openProgressScreen;

@end

@interface SearchEventHandler : NSObject <SearchViewControllerEventHandling>

@property (strong, nonatomic) SearchService *searchService;
@property (weak, nonatomic) id<SearchViewControllerViewing> view;
@property (weak, nonatomic) FlowController *flowController;

- (instancetype)initWithConfiguration:(SearchConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

@end
