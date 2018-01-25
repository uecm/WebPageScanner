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
        if ([URL.absoluteString hasPrefix:@"http://"] || [URL.absoluteString hasPrefix:@"https://"]) {
            self.privateURL = URL;
        } else {
            self.privateURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", URL.absoluteString]];
        }
    }
    return self;
}

-(NSURL *)URL {
    return self.privateURL;
}

@end
