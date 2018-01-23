//
//  URLResponse.m
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "URLResponse.h"

@interface URLResponse()

@property (strong, nonatomic) NSURL *privateURL;
@property (strong, nonatomic) NSString *privateContents;

@end

@implementation URLResponse

- (instancetype)initWithSourceURL:(NSURL *)URL contents:(NSString *)contents {
    self = [super init];
    if (self) {
        self.privateURL = URL;
        self.privateContents = contents;
    }
    return self;
}

- (NSString *)contents {
    return self.privateContents;
}

- (NSURL *)URL {
    return self.privateURL;
}


@end
