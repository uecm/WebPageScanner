//
//  Constants.m
//  WebPageScanner
//
//  Created by Egor on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "Constants.h"

@implementation Constants

//Numbers
NSInteger const kThreadLimit = 50;
NSInteger const kPageLimit = 400;
NSInteger const kDefaultConcurrentLimit = 50;


// Predicates
NSString *const kURLPredicate = @"https?://(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&/=]*)";
NSString *const kURLAbsoluteStringMatchPredicate = @"SELF.absoluteString == %@";


// Storyboard Identifiers
NSString *const kMainStoryboardName = @"Main";

NSString *const kRootNavigationControllerIdentifier = @"RootNavigationController";
NSString *const kMainViewControllerIdentifier = @"ViewControllerIdentifier";
NSString *const kSearchViewControllerIdentifier = @"SearchViewControllerIdentifier";
NSString *const kProgressViewControllerIdentifier = @"ProgressViewControllerIdentifier";


NSString *const kSearchCellIdentifier = @"SearchCellIdentifier";
NSString *const kProgressCellIdentifier = @"ProgressCellIdentifier";

// Alerts
NSString *const kAlertOkButton = @"Ok";

// Alert Titles
NSString *const kIncorrectURLAlertTitle = @"Incorrect URL";
NSString *const kEmptySearchTextAlertTitle = @"Search Text";

NSString *const kTooManyThreadsAlertTitle = @"Thread Number";
NSString *const kZeroThreadsAlertTitle = @"Zero Threads";

NSString *const kTooManyPagesAlertTitle = @"Page Number";
NSString *const kZeroPagesAlertTitle = @"Zero Pages";


// Alert Messages
NSString *const kIncorrectURLAlertMessage = @"Please check if entered URL is valid and try again";
NSString *const kEmptySearchTextAlertMessage = @"Search text field can not be left empty";

NSString *const kTooManyThreadsAlertMessage = @"Thread number is too big, maximum available is 50";
NSString *const kZeroThreadsAlertMessage = @"Thread number can not be equal to zero";

NSString *const kTooManyPagesAlertMessage = @"Page number is too big, maximum available is 400";
NSString *const kZeroPagesAlertMessage = @"Page number can not be equal to zero";


// View State
NSString *const kViewStateIdle = @"Idle";
NSString *const kViewStateLoading = @"Loading";
NSString *const kViewStatePaused = @"Paused";




@end
