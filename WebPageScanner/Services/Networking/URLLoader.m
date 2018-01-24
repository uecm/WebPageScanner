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
#import "LimitedConcurrentQueue.h"

@interface URLLoader()

@property (strong, nonatomic) URLSession *session;
@property (strong, nonatomic) LimitedConcurrentQueue *requestQueue;

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

- (LimitedConcurrentQueue *)requestQueue {
    if (_requestQueue == nil) {
        _requestQueue = [[LimitedConcurrentQueue alloc] initWithLimit:self.maximumConcurrentDownloads];
    }
    return _requestQueue;
}


- (void)loadURL:(NSURL *)URL withCompletion:(void (^)(URLResponse *, NSError *))completion {

    TaskBlock task = ^(TaskCompletionBlock loaderCompletion) {
        [[self.session dataTaskWithURL:URL
                     completionHandler:^(NSData * _Nullable data,
                                         NSURLResponse * _Nullable response,
                                         NSError * _Nullable error) {
                         loaderCompletion(true);
                         URLResponse *urlResponse = [self URLResponseWithResponse:response
                                                                             data:data
                                                                            error:error];
                         completion(urlResponse, error);
                     }] resume];
    };
    [self.requestQueue enqueueTask:task];
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


#pragma mark Private

- (URLResponse *)URLResponseWithResponse:(NSURLResponse *)response
                                    data:(NSData *)data
                                   error:(NSError *)error {
    URLResponse *urlResponse;
    if (error != nil) {
        urlResponse = [[URLResponse alloc] initWithSourceURL:response.URL
                                                    contents:error.localizedDescription];
    } else {
        NSString *html = [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];
        urlResponse = [[URLResponse alloc] initWithSourceURL:response.URL
                                                    contents:html];
    }
    return urlResponse;
}



@end
