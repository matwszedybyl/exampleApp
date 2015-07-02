//
//  ViewHelper.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/30/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewHelper : NSObject
+(void) showAlertForTitle:(NSString *)title andTheMessage:(NSString *)message andAccessibilityLabel:(NSString *)label;
@end
