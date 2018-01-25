//
//  SearchViewConfiguration.h
//  WebPageScanner
//
//  Created by Egor on 1/25/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchConfiguration;





@interface SearchViewConfiguration : NSObject

@property (strong, nonatomic) NSURL *startURL;
@property (strong, nonatomic) NSString *searchText;
@property (assign, nonatomic) NSInteger maxPagesNumber;
@property (assign, nonatomic) NSInteger threadNumber;
@property (strong, nonatomic) NSString  *viewState;
@property (assign, nonatomic) NSInteger loadedPagesNumber;
@property (assign, nonatomic) NSInteger textMatches;

- (instancetype)initWithSearchConfiguration:(SearchConfiguration *)configuration;

@end
