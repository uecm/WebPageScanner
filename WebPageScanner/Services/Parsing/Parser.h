//
//  Parser.h
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

- (NSInteger)numberOfMatchesForText:(NSString *)text inContentsOfPage:(NSString *)page;

- (NSArray<NSString *> *)linksInContentsOfPage:(NSString *)page;


@end
