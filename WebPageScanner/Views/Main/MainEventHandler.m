//
//  MainEventHandler.m
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "MainEventHandler.h"
#import "MainViewController.h"

#import "SearchConfiguration.h"
#import "Parser.h"
#import "Constants.h"

#import "FlowController.h"

@interface MainEventHandler() 

@property (strong, nonatomic) SearchConfiguration *searchConfiguration;

@end


@implementation MainEventHandler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.searchConfiguration = [[SearchConfiguration alloc] init];
    }
    return self;
}

#pragma mark - Public

- (void)setURLWithString:(NSString *)URLString {
    if (![self validateURLWithString:URLString]) {
        [self.view showAlertWithTitle:kIncorrectURLAlertTitle
                         message:kIncorrectURLAlertMessage];
        return;
    }
    NSURL *URL = [NSURL URLWithString:URLString];
    self.searchConfiguration.URL = URL;
}

- (void)setSearchText:(NSString *)searchText {
    self.searchConfiguration.searchText = searchText;
}

- (void)setThreadNumber:(NSInteger)threads {
    if ([self validateThreadAmountWithNumber:threads]) {
        self.searchConfiguration.threadNumber = threads;
    }
}

- (void)setPageNumber:(NSInteger)pages {
    if ([self validatePageAmountWithNumber:pages]) {
        self.searchConfiguration.maxPagesNumber = pages;
    }
}

- (void)showSearchScreen {
    if (![self validateSearchConfiguration]) {
        return;
    }
    SearchViewController *searchController = [self.flowController initializeSearchViewControllerWithConfiguration:self.searchConfiguration];
    [self.view showViewController:(UIViewController *)searchController];
}


#pragma mark - Private

- (BOOL)validateSearchConfiguration {
    if (![self validateURLWithString:self.searchConfiguration.URL.absoluteString]) {
        return false;
    }
    if (![self validatePageAmountWithNumber:self.searchConfiguration.maxPagesNumber]) {
        return false;
    }
    if (![self validateThreadAmountWithNumber:self.searchConfiguration.threadNumber]) {
        return false;
    }
    if (![self validateSearchTextWithText:self.searchConfiguration.searchText]) {
        return false;
    }
    return true;
}



- (BOOL)validateURLWithString:(NSString *)URLString {
    if (![self.parser stringMatchesURLPattern:URLString]) {
        [self.view showAlertWithTitle:kIncorrectURLAlertTitle
                              message:kIncorrectURLAlertMessage];
        return false;
    }
    return true;
}

- (BOOL)validatePageAmountWithNumber:(NSInteger)pages {
    if (pages > kPageLimit) {
        [self.view showAlertWithTitle:kTooManyPagesAlertTitle
                              message:kTooManyPagesAlertMessage];
        return false;
    } else if (pages == 0) {
        [self.view showAlertWithTitle:kZeroPagesAlertTitle
                              message:kZeroPagesAlertMessage];
        return false;
    }
    return true;
}

- (BOOL)validateThreadAmountWithNumber:(NSInteger)threads {
    if (threads > kThreadLimit) {
        [self.view showAlertWithTitle:kTooManyThreadsAlertTitle
                              message:kTooManyThreadsAlertMessage];
        return false;
    } else if (threads == 0) {
        [self.view showAlertWithTitle:kZeroThreadsAlertTitle
                              message:kZeroThreadsAlertMessage];
        return false;
    }
    return true;
}

- (BOOL)validateSearchTextWithText:(NSString *)text {
    if (text.length == 0) {
        [self.view showAlertWithTitle:kEmptySearchTextAlertTitle
                              message:kEmptySearchTextAlertMessage];
        return false;
    }
    return true;
}

@end
