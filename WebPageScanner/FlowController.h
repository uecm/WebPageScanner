//
//  FlowController.h
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MainViewController;
@class SearchViewController;
@class SearchConfiguration;
@class ProgressViewController;
@class SearchService;


@interface FlowController : NSObject


- (__kindof UIViewController *)initializeAppEntryPoint;

- (MainViewController *)initializeMainViewController;
- (SearchViewController *)initializeSearchViewControllerWithConfiguration:(SearchConfiguration *)configuration;
- (ProgressViewController *)initializeProgressViewControllerWithSearchService:(SearchService *)searchService;

@end
