//
//  LimitedConcurrentQueue.h
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TaskCompletionBlock)(BOOL completed);
typedef void(^TaskBlock)(TaskCompletionBlock completionBlock);

@interface LimitedConcurrentQueue : NSObject

- (instancetype)initWithLimit:(NSInteger)limit NS_DESIGNATED_INITIALIZER;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

- (void)enqueueTask:(TaskBlock)task;
- (void)suspend;
- (void)resume;
- (void)invalidateQueues;

@end
