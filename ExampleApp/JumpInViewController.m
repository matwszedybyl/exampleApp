//
//  JumpInViewController.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/23/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import "JumpInViewController.h"
#import "CameraViewController.h"
#import "ScrollingPageViewController.h"
#import "ViewHelper.h"

@interface JumpInViewController ()
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *password;

@end

@implementation JumpInViewController


- (IBAction)SignUpButton:(UIButton *)sender
{
    self.userName = self.usernameTextField.text;
    self.password = self.passwordTextField.text;
    [self signUp];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)signUp
{
    
}

- (IBAction)jumpIn:(id)sender {
    if([self validUsername] && [self validPassword]){
        [self performSegueWithIdentifier:@"JumpIntoCameraSegue" sender:self];
    } else {
        [self performSegueWithIdentifier:@"JumpIntoCameraSegue" sender:self];

//        [ViewHelper showAlertForTitle:@"Invalid Credentials" andTheMessage:@"Please check your login information" andAccessibilityLabel:@"Network Error"];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"JumpIntoCameraSegue"]){
        if([segue.destinationViewController isKindOfClass:[ScrollingPageViewController class]]){
            self.userName = self.usernameTextField.text;
                self.password = self.passwordTextField.text;
                ScrollingPageViewController *cvc = (ScrollingPageViewController *)segue.destinationViewController;
                cvc.usernameString = self.userName;
                cvc.passwordString = self.password;
            
        }
    }
}

- (BOOL)validUsername
{
    NSString *username = [self.usernameTextField text];
    if ([username isEqualToString:@"Paul"] || [username isEqualToString:@"Mat"])
    {
        return TRUE;
    }
        return FALSE;
    
}


- (BOOL)validPassword
{
    NSString *username = [self.usernameTextField text];
    NSString *password = [self.passwordTextField text];
    if (([username isEqualToString:@"Paul"] && [password isEqualToString:@"ABC"]) ||
        ([username isEqualToString:@"Mat"] && [password isEqualToString:@"DEF"]))
    {
        return TRUE;
    }
    
    return FALSE;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    self.tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tapRecognizer];    // Do any additional setup after loading the view.
}

-(void)hideKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
//    self.tapRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
