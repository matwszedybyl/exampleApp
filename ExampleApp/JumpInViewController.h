//
//  JumpInViewController.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/23/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import "ViewController.h"

@interface JumpInViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic) UITapGestureRecognizer *tapRecognizer;

- (IBAction)jumpIn:(id)sender;


@end
