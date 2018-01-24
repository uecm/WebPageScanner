//
//  URLSession.h
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLSession : NSURLSession

+ (URLSession *)sessionWithConcurrentRequestLimit:(NSInteger)limit;

@end
