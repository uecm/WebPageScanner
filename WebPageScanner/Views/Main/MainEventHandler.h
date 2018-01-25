//
//  MainEventHandler.h
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Parser;
@class FlowController;

@protocol MainViewControllerViewing;

@protocol MainViewControllerEventHandling <NSObject>
@required
- (void)setURLWithString:(NSString *)URLString;
- (void)setSearchText:(NSString *)searchText;
- (void)setThreadNumber:(NSInteger)threads;
- (void)setPageNumber:(NSInteger)pages;

- (void)showSearchScreen;

@end



@interface MainEventHandler : NSObject <MainViewControllerEventHandling>

@property (weak, nonatomic) FlowController *flowController;
@property (weak, nonatomic) id<MainViewControllerViewing> view;
@property (strong, nonatomic) Parser *parser;


@end
