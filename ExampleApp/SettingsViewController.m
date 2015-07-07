//
//  SettingsViewController.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 7/6/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import "SettingsViewController.h"
#import "CameraViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"SwipeToCamera" sender:self];

}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SwipeToCamera"])
    {
        if([segue.destinationViewController isKindOfClass:[CameraViewController class]]){
            CameraViewController *cvc = (CameraViewController *)[segue destinationViewController];
            
        }
    }
}


@end
