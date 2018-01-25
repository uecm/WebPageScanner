//
//  ButtonsTableViewCell.h
//  WebPageScanner
//
//  Created by Egor on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SearchButtonActionType) {
    SearchButtonActionTypeStart,
    SearchButtonActionTypePause,
    SearchButtonActionTypeStop
};

typedef void(^SearchButtonActionHandler)(SearchButtonActionType actionType);

@interface ButtonsTableViewCell : UITableViewCell

@property (strong, nonatomic) SearchButtonActionHandler actionHandler;

@end
