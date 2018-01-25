//
//  TextFieldTableViewCell.h
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TextFieldTableViewCellType) {
    TextFieldTableViewCellTypeURL,
    TextFieldTableViewCellTypeSearchText,
    TextFieldTableViewCellTypeThread,
    TextFieldTableViewCellTypePage
};


typedef void(^TextFieldReturnHandler)(NSString *text);

@interface TextFieldTableViewCell : UITableViewCell

@property (strong, nonatomic) TextFieldReturnHandler returnHandler;

@property (weak, nonatomic) TextFieldTableViewCell *nextCell;


@end
