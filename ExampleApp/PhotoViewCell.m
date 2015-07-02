//
//  PhotoViewCell.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/30/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import "PhotoViewCell.h"

@implementation PhotoViewCell
@synthesize thumbnailImage, usernameLabel, timestampLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
