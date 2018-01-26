//
//  Constants.h
//  WebPageScanner
//
//  Created by Egor on 1/23/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

//Numbers
extern NSInteger const kThreadLimit;
extern NSInteger const kPageLimit;
extern NSInteger const kDefaultConcurrentLimit;

// Predicates
extern NSString *const kURLPredicate;
extern NSString *const kURLAbsoluteStringMatchPredicate;
extern NSString *const kURLHTTPPrefix;
extern NSString *const kURLHTTPSPrefix;

// Storyboard Identifiers
extern NSString *const kMainStoryboardName;

extern NSString *const kRootNavigationControllerIdentifier;
extern NSString *const kMainViewControllerIdentifier;
extern NSString *const kSearchViewControllerIdentifier;
extern NSString *const kProgressViewControllerIdentifier;


extern NSString *const kSearchCellIdentifier;
extern NSString *const kProgressCellIdentifier;
extern NSString *const kProgressViewCellIdentifier;

/// Alerts
extern NSString *const kAlertOkButton;

// Alert Titles
extern NSString *const kIncorrectURLAlertTitle;
extern NSString *const kEmptySearchTextAlertTitle;

extern NSString *const kTooManyThreadsAlertTitle;
extern NSString *const kZeroThreadsAlertTitle;

extern NSString *const kTooManyPagesAlertTitle;
extern NSString *const kZeroPagesAlertTitle;

// Alert Messages
extern NSString *const kIncorrectURLAlertMessage;
extern NSString *const kEmptySearchTextAlertMessage;

extern NSString *const kTooManyThreadsAlertMessage;
extern NSString *const kZeroThreadsAlertMessage;

extern NSString *const kTooManyPagesAlertMessage;
extern NSString *const kZeroPagesAlertMessage;

extern NSString *const kSuccessSearchObjectMessage;

// View State
extern NSString *const kViewStateIdle;
extern NSString *const kViewStateLoading;
extern NSString *const kViewStatePaused;


// Search Object State
extern NSString *const kSearchObjectStatusPendingDescription;
extern NSString *const kSearchObjectStatusLoadingDescription;
extern NSString *const kSearchObjectStatusSuccessDescription;
extern NSString *const kSearchObjectStatusNetworkErrorDescription;
extern NSString *const kSearchObjectStatusSuspendedDescription;
extern NSString *const kSearchObjectStatusCancelledDescription;


@end
