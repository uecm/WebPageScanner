//
//  ButtonsTableViewCell.m
//  WebPageScanner
//
//  Created by Egor on 1/24/18.
//  Copyright © 2018 Egor. All rights reserved.
//

#import "ButtonsTableViewCell.h"

@interface ButtonsTableViewCell()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;

@end

@implementation ButtonsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIButton *button in self.buttonCollection) {
        button.layer.cornerRadius = 8;
        button.layer.borderWidth = 1;
        button.layer.borderColor = button.tintColor.CGColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)pauseButtonAction:(UIButton *)sender {
    if (self.actionHandler) {
        self.actionHandler(SearchButtonActionTypePause);
    }
}

- (IBAction)startButtonAction:(UIButton *)sender {
    if (self.actionHandler) {
        self.actionHandler(SearchButtonActionTypeStart);
    }
}

- (IBAction)stopButtonAction:(UIButton *)sender {
    if (self.actionHandler) {
        self.actionHandler(SearchButtonActionTypeStop);
    }
}

@end
