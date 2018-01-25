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


@interface FlowController : NSObject

- (MainViewController *)initializeMainViewController;
- (SearchViewController *)initializeSearchViewControllerWithConfiguration:(SearchConfiguration *)configuration;
- (__kindof UIViewController *)initializeAppEntryPoint;

@end
