//
//  TextFieldTableViewCell.m
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@interface TextFieldTableViewCell() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldOutlet;

@end

@implementation TextFieldTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textFieldOutlet.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)becomeFirstResponder {
    return [self.textFieldOutlet becomeFirstResponder];
}


#pragma mark Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.nextCell) {
        [self.nextCell becomeFirstResponder];
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.returnHandler) {
        self.returnHandler(textField.text);
    }
}



@end
