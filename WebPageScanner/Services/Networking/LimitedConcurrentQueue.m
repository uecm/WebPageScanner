//
//  LimitedConcurrentQueue.m
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "LimitedConcurrentQueue.h"

@interface LimitedConcurrentQueue()

@property (strong, nonatomic) dispatch_queue_t concurrentQueue;
@property (strong, nonatomic) dispatch_queue_t serialQueue;
@property (strong, nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation LimitedConcurrentQueue

- (instancetype)initWithLimit:(NSInteger)limit {
    self = [super init];
    if (self) {
        self.concurrentQueue = dispatch_queue_create("com.egor.Test-Task.WebConcurrent", nil);
        self.serialQueue = dispatch_queue_create("com.egor.Test-Task.WebSerial", DISPATCH_QUEUE_SERIAL);
        self.semaphore = dispatch_semaphore_create(limit);
    }
    return self;
}


- (void)enqueueTask:(TaskBlock)task {
    if (!task) {
        NSAssert(!task, @"Provided task is nil");
    }
    dispatch_async(self.serialQueue, ^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(self.concurrentQueue, ^{
            task(^(BOOL completed) {
                dispatch_semaphore_signal(self.semaphore);
            });
        });
    });
}

- (void)suspend {
    dispatch_suspend(self.concurrentQueue);
    dispatch_suspend(self.serialQueue);
}

- (void)resume {
    dispatch_resume(self.concurrentQueue);
    dispatch_resume(self.serialQueue);
}


@end
