//
//  FlowController.m
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowController.h"
#import "ServiceFactory.h"
#import "Constants.h"

#import "MainViewController.h"
#import "MainEventHandler.h"

#import "SearchViewController.h"
#import "SearchEventHandler.h"
#import "SearchConfiguration.h"

#import "ProgressViewController.h"
#import "ProgressEventHandler.h"


@interface FlowController()

@property (strong, nonatomic) ServiceFactory *serviceFactory;

@end

@implementation FlowController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.serviceFactory = [[ServiceFactory alloc] init];
    }
    return self;
}

- (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:kMainStoryboardName bundle:nil];
}

- (UINavigationController *)initializeRootNavigationController {
    return (UINavigationController *)[[self mainStoryboard]
               instantiateViewControllerWithIdentifier:kRootNavigationControllerIdentifier];
}


- (__kindof UIViewController *)initializeAppEntryPoint {
    UINavigationController *navigationController = [self initializeRootNavigationController];
    MainViewController *rootController = [self initializeMainViewController];
    navigationController.viewControllers = @[rootController];
    return navigationController;
}


// View Wireframes

- (MainViewController *)initializeMainViewController {
    MainViewController *controller = (MainViewController *)[[UIStoryboard storyboardWithName:kMainStoryboardName bundle:nil] instantiateViewControllerWithIdentifier:kMainViewControllerIdentifier];
    MainEventHandler *eventHandler = [[MainEventHandler alloc] init];

    Parser *parser = [self.serviceFactory initializeParser];
    eventHandler.parser = parser;
    eventHandler.view = controller;
    eventHandler.flowController = self;
    
    controller.eventHandler = eventHandler;
    return controller;
}

- (SearchViewController *)initializeSearchViewControllerWithConfiguration:(SearchConfiguration *)configuration {
    SearchViewController *searchController = [[self mainStoryboard] instantiateViewControllerWithIdentifier:kSearchViewControllerIdentifier];
    SearchEventHandler *eventHandler = [[SearchEventHandler alloc] initWithConfiguration:configuration];
    
    URLLoader *loader = [self.serviceFactory initializeURLLoaderWithConcurrentLimit:configuration.threadNumber];
    eventHandler.searchService = [self.serviceFactory initializeSearchServiceWithURLLoader:loader];
    eventHandler.view = searchController;
    eventHandler.flowController = self;
    
    searchController.eventHandler = eventHandler;
    return searchController;
}

- (ProgressViewController *)initializeProgressViewControllerWithSearchService:(SearchService *)searchService {

    ProgressViewController *viewController = [[UIStoryboard storyboardWithName:kMainStoryboardName bundle:nil] instantiateViewControllerWithIdentifier:kProgressViewControllerIdentifier];
    ProgressEventHandler *eventHandler = [[ProgressEventHandler alloc] init];

    eventHandler.view = viewController;
    eventHandler.searchService = searchService;

    viewController.eventHandler = eventHandler;

    return viewController;
}

@end
