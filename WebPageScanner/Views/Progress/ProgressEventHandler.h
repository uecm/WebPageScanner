//
//  ProgressEventHandler.h
//  WebPageScanner
//
//  Created by Greg on 1/25/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchService;
@class SearchObject;
@protocol ProgressViewControllerViewing;

@protocol ProgressViewEventHandling <NSObject>

- (NSArray<SearchObject *> *)dataSource;

- (void)configureView;
- (void)showDetailForItemAtIndex:(NSInteger)index;

@end


@interface ProgressEventHandler : NSObject <ProgressViewEventHandling>

@property (weak, nonatomic) SearchService *searchService;
@property (weak, nonatomic) id<ProgressViewControllerViewing> view;


@end
