//
//  DreamCellTableViewCell.m
//  SixDegrees
//
//  Created by Bhalla, Aditya on 5/12/15.
//  Copyright (c) 2015 Steven Wu. All rights reserved.
//

#import "DreamCellTableViewCell.h"

@implementation DreamCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 5;
    frame.size.width -= 2 * 5;
    [super setFrame:frame];
}

@end
