//
//  TextFieldTableViewCell.m
//  WebPageScanner
//
//  Created by Greg on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@interface TextFieldTableViewCell()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TextFieldTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
