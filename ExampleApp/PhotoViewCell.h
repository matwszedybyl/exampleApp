//
//  PhotoViewCell.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/30/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewCell : UITableViewCell{}
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

