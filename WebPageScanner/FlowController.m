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

- (UINavigationController *)initializeRootNavigationController {
    return (UINavigationController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                      instantiateInitialViewController];
}

- (MainViewController *)initializeMainViewController {
    MainViewController *controller = (MainViewController *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                                            instantiateViewControllerWithIdentifier:kViewControllerIdentifier];
    MainEventHandler *eventHandler = [[MainEventHandler alloc] init];

    URLLoader *loader = [self.serviceFactory initializeURLLoader];
    eventHandler.searchService = [self.serviceFactory initializeSearchServiceWithURLLoader:loader];

    controller.eventHandler = eventHandler;
    return controller;
}

@end
