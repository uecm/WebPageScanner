//
//  SearchObject.h
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SearchObjectStatus) {
    SearchObjectStatusPending,
    SearchObjectStatusSearching,
    SearchObjectStatusSuccess,
    SearchObjectStatusTimeout,
    SearchObjectStatusFailure
};


@interface SearchObject : NSObject

@property (strong, nonatomic, readonly) NSURL *URL;
@property (assign, nonatomic) NSInteger wordMatches;
@property (assign, nonatomic) SearchObjectStatus status;

- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

@end



