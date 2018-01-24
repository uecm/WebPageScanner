//
//  ServiceFactory.m
//  WebPageScanner
//
//  Created by Egor on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "ServiceFactory.h"
#import "URLLoader.h"
#import "SearchService.h"
#import "Parser.h"

@implementation ServiceFactory

#pragma mark URL Loader
- (URLLoader *)initializeURLLoader {
    return [[URLLoader alloc] init];
}

- (URLLoader *)initializeURLLoaderWithConcurrentLimit:(NSInteger)limit {
    URLLoader *loader = [self initializeURLLoader];
    loader.maximumConcurrentDownloads = limit;
    return loader;
}


#pragma mark Search Service
- (SearchService *) initializeSearchService {
    return [[SearchService alloc] init];
}

- (SearchService *)initializeSearchServiceWithURLLoader:(URLLoader *)loader {
    Parser *parser = [self initializeParser];
    return [[SearchService alloc] initWithLoader:loader parser:parser];
}


#pragma mark Parser
- (Parser *)initializeParser {
    return [[Parser alloc] init];
}

@end
