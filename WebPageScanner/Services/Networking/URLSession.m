//
//  URLSession.m
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "URLSession.h"

@implementation URLSession

+ (URLSession *)sessionWithConcurrentRequestLimit:(NSInteger)limit {
    NSURLSessionConfiguration *configuration = [URLSession configurationWithLimit:limit];
    return (URLSession *)[NSURLSession sessionWithConfiguration:configuration];
}


+ (NSURLSessionConfiguration *)configurationWithLimit:(NSInteger)limit {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPMaximumConnectionsPerHost = limit;
    configuration.timeoutIntervalForRequest = 5;
    return configuration;
}


@end
