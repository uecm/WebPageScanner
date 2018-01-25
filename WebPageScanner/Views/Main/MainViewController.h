//
//  ViewController.h
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainEventHandler;

@protocol MainViewControllerEventHandling;

@protocol MainViewControllerViewing <NSObject>
@required
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;
- (void)showViewController:(__kindof UIViewController *)controller;

@end

@interface MainViewController : UITableViewController <MainViewControllerViewing>

@property (strong, nonatomic) id<MainViewControllerEventHandling> eventHandler;


@end



