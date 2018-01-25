//
//  SearchViewConfiguration.m
//  WebPageScanner
//
//  Created by Egor on 1/25/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "SearchViewConfiguration.h"
#import "SearchConfiguration.h"

@implementation SearchViewConfiguration

- (instancetype)initWithSearchConfiguration:(SearchConfiguration *)configuration {
    self = [super init];
    if (self) {
        self.startURL = configuration.URL;
        self.searchText = configuration.searchText;
        self.maxPagesNumber = configuration.maxPagesNumber;
        self.threadNumber = configuration.threadNumber;
        self.viewState = @"";
        self.loadedPagesNumber = 0;
        self.textMatches = 0;
    }
    return self;
}


@end
