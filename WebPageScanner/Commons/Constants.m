//
//  Constants.m
//  WebPageScanner
//
//  Created by Egor on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString *const kURLPredicate = @"https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]\
                            {2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)";

NSString *const kURLAbsoluteStringMatchPredicate = @"SELF.absoluteString == %@";



// View Controller Identifiers
NSString *const kViewControllerIdentifier = @"ViewControllerIdentifier";

@end
