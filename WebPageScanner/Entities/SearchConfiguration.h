//
//  SearchConfiguration.h
//  WebPageScanner
//
//  Created by Egor on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchConfiguration : NSObject

@property (strong, nonatomic) NSURL *URL;
@property (strong, nonatomic) NSString *searchText;
@property (assign, nonatomic) NSInteger maxPagesNumber;
@property (assign, nonatomic) NSInteger threadNumber;

@end
