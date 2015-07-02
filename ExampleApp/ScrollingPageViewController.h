//
//  ScrollingPageViewController.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/24/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollingPageViewController : UIPageViewController
<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) NSString *usernameString;
@property (nonatomic, strong) NSString *passwordString;
@end
