//
//  ServiceFactory.h
//  WebPageScanner
//
//  Created by Egor on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchService;
@class URLLoader;
@class Parser;

@interface ServiceFactory : NSObject

- (URLLoader *) initializeURLLoader;
- (URLLoader *) initializeURLLoaderWithConcurrentLimit:(NSInteger)limit;

- (SearchService *) initializeSearchService;
- (SearchService *) initializeSearchServiceWithURLLoader:(URLLoader *)loader;

- (Parser *) initializeParser;

@end
