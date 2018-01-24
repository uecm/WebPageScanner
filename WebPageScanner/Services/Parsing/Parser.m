//
//  Parser.m
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "Parser.h"
#import "Constants.h"

@implementation Parser


- (NSInteger)numberOfMatchesForText:(NSString *)text inContentsOfPage:(NSString *)page {
    NSArray *matches = [self matchesInString:page forPattern:text];
    return matches.count;
}

- (NSArray<NSString *> *)linksInContentsOfPage:(NSString *)page {
    NSMutableArray<NSString *> *links = [[NSMutableArray alloc] init];
    
    NSArray<NSTextCheckingResult *> *matches = [self matchesInString:page
                                                          forPattern:kURLPredicate];
    for (NSTextCheckingResult *result in matches) {
        NSString *link = [page substringWithRange:result.range];
        [links addObject:link];
    }
    
    return [links copy];
}



#pragma mark Private

- (NSArray<NSTextCheckingResult *> *)matchesInString:(NSString *)string forPattern:(NSString *)pattern {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:string
                                                              options:0
                                                                range:NSMakeRange(0, string.length)];
    return matches;
}


@end
