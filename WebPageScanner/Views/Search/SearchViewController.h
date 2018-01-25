//
//  SearchViewController.h
//  WebPageScanner
//
//  Created by Egor on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchEventHandler;
@class SearchViewConfiguration;

@protocol SearchViewControllerEventHandling;

@protocol SearchViewControllerViewing <NSObject>
@required

- (void)updateWithViewConfiguration:(SearchViewConfiguration *)configuration;

@end

@interface SearchViewController : UITableViewController <SearchViewControllerViewing>

@property (strong, nonatomic) id<SearchViewControllerEventHandling> eventHandler;

@end
