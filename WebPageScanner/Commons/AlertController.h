//
//  AlertController.h
//  WebPageScanner
//
//  Created by Egor on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : UIAlertController

+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message
                   buttonTitle:(NSString *)buttonTitle;

@end
