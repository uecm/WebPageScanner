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
    if (!page) {
        return nil;
    }
    NSMutableArray<NSString *> *links = [[NSMutableArray alloc] init];
    NSError *error = nil;
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                                   error:&error];
    
    NSArray<NSTextCheckingResult *> *matches = [linkDetector matchesInString:page
                                                                     options:0
                                                                       range:NSMakeRange(0, page.length)];
    for (NSTextCheckingResult *result in matches) {
        NSString *link = [page substringWithRange:result.range];
        [links addObject:link];
    }
    return [links copy];
}

- (BOOL)stringMatchesURLPattern:(NSString *)string {
    if (!string) {
        return false;
    }
    NSError *error = nil;
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    return [linkDetector matchesInString:string options:0 range:NSMakeRange(0, string.length)].count > 0;
}



#pragma mark - Private

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
