//
//  ProgressEventHandler.h
//  WebPageScanner
//
//  Created by Greg on 1/25/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchService;
@protocol ProgressViewControllerViewing;

@protocol ProgressViewEventHandling <NSObject>

- (void)configureView;

@end


@interface ProgressEventHandler : NSObject <ProgressViewEventHandling>

@property (weak, nonatomic) SearchService *searchService;
@property (weak, nonatomic) id<ProgressViewControllerViewing> view;


@end
