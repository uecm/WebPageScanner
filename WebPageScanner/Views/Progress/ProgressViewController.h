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


typedef NS_ENUM(NSInteger, ItemUpdateActionType) {
    ItemUpdateActionTypeReload,
    ItemUpdateActionTypeAdd
};


@protocol ProgressViewControllerViewing <NSObject>

- (void)updateItemAtIndex:(NSInteger)index
           withActionType:(ItemUpdateActionType)actionType;
- (void)configureTableView;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end


@interface ProgressViewController : UITableViewController <ProgressViewControllerViewing>

@property (strong, nonatomic) id<ProgressViewEventHandling> eventHandler;

@end
