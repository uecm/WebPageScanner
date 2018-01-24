//
//  MainEventHandler.h
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchService;


@interface MainEventHandler : NSObject

@property (strong, nonatomic) SearchService *searchService;

@end
