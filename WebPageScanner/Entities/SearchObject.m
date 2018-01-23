//
//  SearchObject.m
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "SearchObject.h"

@interface SearchObject()

@property (strong, nonatomic) NSURL *privateURL;

@end


@implementation SearchObject


- (instancetype)initWithURL:(NSURL *)URL {
    self = [super init];
    if (self) {
        self.privateURL = URL;
    }
    return self;
}

-(NSURL *)URL {
    return self.privateURL;
}

@end
