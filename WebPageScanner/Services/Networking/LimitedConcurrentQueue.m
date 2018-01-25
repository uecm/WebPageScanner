//
//  LimitedConcurrentQueue.m
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "LimitedConcurrentQueue.h"

@interface LimitedConcurrentQueue()

@property (strong, atomic) dispatch_semaphore_t semaphore;
@property (strong, nonatomic) NSOperationQueue *operationQueue;

@end

@implementation LimitedConcurrentQueue

- (instancetype)initWithLimit:(NSInteger)limit {
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(limit);
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = limit;
    }
    return self;
}


- (void)enqueueTask:(TaskBlock)task {
    if (!task) {
        NSAssert(!task, @"Provided task is nil");
    }
    [self.operationQueue addOperationWithBlock:^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        task(^(BOOL completed) {
            dispatch_semaphore_signal(self.semaphore);
        });
    }];
}


- (void)invalidateQueues {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        if (self.operationQueue) {
            [self.operationQueue cancelAllOperations];
        }
        if (self.semaphore) {
            dispatch_semaphore_wait(self.semaphore, 0);
        }
    });
}

- (void)suspend {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.operationQueue setSuspended:true];
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    });
}

- (void)resume {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.operationQueue setSuspended:false];
        dispatch_semaphore_signal(self.semaphore);
    });
}


@end
