//
//  ViewHelper.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/30/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ViewHelper.h"

@implementation ViewHelper

+(void) showAlertForTitle:(NSString *)title andTheMessage:(NSString *)message andAccessibilityLabel:(NSString *)label
{
    UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [successAlert setAccessibilityLabel:label];
    [successAlert show];
}

@end
