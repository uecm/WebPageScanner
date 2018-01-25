//
//  URLLoader.h
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class URLResponse;

@interface URLLoader : NSObject

@property (assign, nonatomic) NSInteger maximumConcurrentDownloads;

- (void)loadURL:(NSURL *)URL
    withCompletion:(void (^)(URLResponse *response, NSError *error))completion;

- (void)pauseLoading;
- (void)stopLoading;

@end
