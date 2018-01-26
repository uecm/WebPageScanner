//
//  SearchObject.m
//  WebPageScanner
//
//  Created by Greg on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "SearchObject.h"
#import "Constants.h"

@interface SearchObject()

@property (strong, nonatomic) NSURL *privateURL;

@end


@implementation SearchObject

- (instancetype)initWithURL:(NSURL *)URL {
    self = [super init];
    if (self) {
        if ([URL.absoluteString hasPrefix:kURLHTTPPrefix] ||
            [URL.absoluteString hasPrefix:kURLHTTPSPrefix]) {
            self.privateURL = URL;
        } else {
            self.privateURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kURLHTTPPrefix, URL.absoluteString]];
        }
    }
    return self;
}

-(NSURL *)URL {
    return self.privateURL;
}

- (NSString *)statusDescription {
    switch (self.status) {
        case SearchObjectStatusLoading:
            return kSearchObjectStatusLoadingDescription;
            break;
        case SearchObjectStatusPending:
            return kSearchObjectStatusPendingDescription;
            break;
        case SearchObjectStatusSuccess:
            return kSearchObjectStatusSuccessDescription;
            break;
        case SearchObjectStatusCancelled:
            return kSearchObjectStatusCancelledDescription;
            break;
        case SearchObjectStatusSuspended:
            return kSearchObjectStatusSuspendedDescription;
            break;
        case SearchObjectStatusNetworkError:
            return kSearchObjectStatusNetworkErrorDescription;
            break;
        default:
            break;
    }
    return [NSString string];
}

@end
