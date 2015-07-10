//
//  CameraViewController.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 7/9/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CameraViewController.h"
#import <OCMock/OCMock.h>
#import <OCMock/OCMockObject.h>
#import "JumpInViewController.h"

@interface CameraViewControllerTest : XCTestCase


@end

@implementation CameraViewControllerTest

CameraViewController *cameraVC;


- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    cameraVC = [storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    [cameraVC performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [cameraVC performSelectorOnMainThread:@selector(viewWillAppear:) withObject:nil waitUntilDone:YES];
}

- (void)tearDown {
    [super tearDown];
    cameraVC = nil;
}

- (void)testTakePictureButtonExists{
    XCTAssertTrue(cameraVC.takePictureButton.isEnabled);
    XCTAssertFalse(cameraVC.takePictureButton.isHidden);
}

- (void)testTakePictureButtonDoesntExistAfterPictureTaken{
    XCTAssertFalse(cameraVC.takePictureButton.isHidden);
    [cameraVC takePhoto:[OCMArg any]];
    XCTAssertTrue(cameraVC.takePictureButton.isHidden);
}

- (void)testCancelPictureButtonExistsAfterPictureTaken{
    XCTAssertTrue(cameraVC.cancelPicButton.isHidden);
    [cameraVC takePhoto:[OCMArg any]];
    XCTAssertFalse(cameraVC.cancelPicButton.isHidden);
}

- (void)testCancelPictureShowsTakePictureButton{
    XCTAssertFalse(cameraVC.takePictureButton.isHidden);
    [cameraVC takePhoto:[OCMArg any]];
    [cameraVC cancelPhoto:[OCMArg any]];
    XCTAssertFalse(cameraVC.takePictureButton.isHidden);
}

- (void)testPreviewExists{
    [cameraVC takePhoto:[OCMArg any]];
    [cameraVC cancelPhoto:[OCMArg any]];
    XCTAssertFalse(cameraVC.takePictureButton.isHidden);
}

- (void)testPreviewIsGOneAfterPictureTaken{
    XCTAssertFalse(cameraVC.takePictureButton.isHidden);
    [cameraVC takePhoto:[OCMArg any]];
    XCTAssertFalse(cameraVC.takePictureButton.isHidden);
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
