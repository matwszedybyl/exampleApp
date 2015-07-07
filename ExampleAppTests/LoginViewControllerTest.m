//
//  LoginViewControllerTest.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 7/2/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <OCMock/OCMockObject.h>
#import "JumpInViewController.h"
#import "ViewHelper.h"

@interface LoginViewControllerTest : XCTestCase

@end

@implementation LoginViewControllerTest

JumpInViewController *jumpInVCTest;


- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    jumpInVCTest = [storyboard instantiateViewControllerWithIdentifier:@"JumpInViewController"];
    [jumpInVCTest performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    jumpInVCTest = nil;
}

- (void)testInvalidCredentials {
    jumpInVCTest.usernameTextField.text =  @"x";
    jumpInVCTest.passwordTextField.text =  @"y";
    XCTAssertNotNil(jumpInVCTest.usernameTextField);
    id viewHelperMock = OCMClassMock([ViewHelper class]);
    OCMStub([viewHelperMock showAlertForTitle:@"Invalid Credentials" andTheMessage:@"Please check your login information" andAccessibilityLabel:@""]);
    [jumpInVCTest jumpIn:nil];
    OCMVerify([viewHelperMock showAlertForTitle:@"Invalid Credentials" andTheMessage:@"Please check your login information" andAccessibilityLabel:@""]);

}

- (void)testValidCredentials {
    id partialMock = OCMPartialMock(jumpInVCTest);
    OCMStub([partialMock performSegueWithIdentifier:[OCMArg any] sender:[OCMArg any]]);
    jumpInVCTest.usernameTextField.text =  @"Mat";
    jumpInVCTest.passwordTextField.text =  @"DEF";
    XCTAssertNotNil(jumpInVCTest.usernameTextField);
    XCTAssertNoThrow([jumpInVCTest jumpIn:nil]);
    OCMVerify([partialMock performSegueWithIdentifier:[OCMArg any] sender:[OCMArg any]]);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
