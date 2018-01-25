//
//  ProgressViewController.h
//  WebPageScanner
//
//  Created by Greg on 1/25/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchObject;
@protocol ProgressViewEventHandling;


@protocol ProgressViewControllerViewing <NSObject>

- (void)updateViewWithDataSource:(NSArray<SearchObject *> *)dataSource;
- (void)updateViewWithSearchObject:(SearchObject *)searchObject;

@end


@interface ProgressViewController : UITableViewController <ProgressViewControllerViewing>

@property (strong, nonatomic) id<ProgressViewEventHandling> eventHandler;

@end
