//
//  ImageViewController.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 7/1/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Photo.h"

@interface ImageViewController : UIViewController

@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) Photo *photo;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, weak) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end
