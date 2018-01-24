//
//  URLLoader.m
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "URLLoader.h"
#import "URLSession.h"
#import "URLResponse.h"

@interface URLLoader()

@property (strong, nonatomic) URLSession *session;

@end


@implementation URLLoader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maximumConcurrentDownloads = 5; // Default value if not set
    }
    return self;
}


- (URLSession *)session {
    if (_session == nil) {
        _session = [URLSession sessionWithConcurrentRequestLimit:self.maximumConcurrentDownloads];
    }
    return _session;
}


- (void)loadURL:(NSURL *)URL withCompletion:(void (^)(URLResponse *, NSError *))completion {
    [[self.session dataTaskWithURL:URL
                 completionHandler:^(NSData * _Nullable data,
                                     NSURLResponse * _Nullable response,
                                     NSError * _Nullable error) {
                     URLResponse *urlResponse;
                     if (error != nil) {
                         urlResponse = [[URLResponse alloc] initWithSourceURL:URL
                                                                     contents:error.localizedDescription];
                     } else {
                         NSString *html = [[NSString alloc] initWithData:data
                                                                encoding:NSUTF8StringEncoding];
                         urlResponse = [[URLResponse alloc] initWithSourceURL:URL
                                                                     contents:html];
                     }
                     completion(urlResponse, error);
                 }] resume];
}

- (void)pauseLoading {
    [self.session getAllTasksWithCompletionHandler:^(NSArray<__kindof NSURLSessionTask *> * _Nonnull tasks) {
        for (NSURLSessionTask *task in tasks) {
            [task suspend];
        }
    }];
}

- (void)stopLoading {
    [self.session invalidateAndCancel];
    self.session = nil;
}



@end
