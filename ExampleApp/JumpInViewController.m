//
//  JumpInViewController.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/23/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//
// mat is the coolest guy alive


#import "JumpInViewController.h"
#import "CameraViewController.h"
#import "ScrollingPageViewController.h"
#import "ViewHelper.h"
#import "TableListViewController.h"
#import "Photographer.h"

@interface JumpInViewController ()
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *password;

@end

@implementation JumpInViewController
NSCache *cache;
AppDelegate *appDelegate;
NSString *usernameString;
NSUserDefaults *userDefaults;

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
    [self saveUser];
}


-(void) saveUser
{
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    if ([appDelegate managedObjectContext] == nil)
    {
        context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        NSLog(@"After managedObjectContext: %@",  context);
    }
    
    NSString *usernameString = self.usernameTextField.text;
    NSString *passwordString = self.passwordTextField.text;
    NSManagedObject *newPhotographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];

    [newPhotographer setValue:usernameString forKey:@"name"];
    [newPhotographer setValue:passwordString forKey:@"password"];
    
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    } else {
        NSLog(@"Saved");

    }
    
}

- (IBAction)jumpIn:(id)sender {
    if([self validUsername] && [self validPassword]){
        [self performSegueWithIdentifier:@"Go To Photo List" sender:self];
        appDelegate = [[UIApplication sharedApplication] delegate];
        cache = [appDelegate appCache];
        userDefaults = [appDelegate userDefaults];
        [cache setObject:self.usernameTextField.text forKey:@"currentPhotographer"];
        [userDefaults setObject:self.usernameTextField.text forKey:@"currentPhotographer"];
    } else {
        [self performSegueWithIdentifier:@"Go To Photo List" sender:self];
        [ViewHelper showAlertForTitle:@"Invalid Credentials" andTheMessage:@"Please check your login information" andAccessibilityLabel:@""];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     if([segue.identifier isEqualToString:@"Go To Photo List"]){
        if([segue.destinationViewController isKindOfClass:[TableListViewController class]]){
        self.userName = self.usernameTextField.text;
        self.password = self.passwordTextField.text;
            
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
    [self.view addGestureRecognizer:self.tapRecognizer];
}

-(void)hideKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
