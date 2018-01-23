//
//  URLResponse.h
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLResponse : NSObject

@property (strong, nonatomic, readonly) NSURL *URL;
@property (strong, nonatomic, readonly) NSString *contents;

- (instancetype)initWithSourceURL:(NSURL *)URL contents:(NSString *)contents;

@end
