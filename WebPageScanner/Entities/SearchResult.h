//
//  SearchResult.h
//  WebPageScanner
//
//  Created by Egor on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSURL *startURL;
@property (assign, nonatomic) NSInteger totalTextMatches;
@property (assign, nonatomic) NSInteger totalErrors;

@end
