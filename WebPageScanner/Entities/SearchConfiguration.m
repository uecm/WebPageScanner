//
//  SearchConfiguration.m
//  WebPageScanner
//
//  Created by Egor on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "SearchConfiguration.h"

@implementation SearchConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        self.URL = nil;
        self.searchText = @"";
        self.threadNumber = 0;
        self.maxPagesNumber = 0;
    }
    return self;
}

@end
