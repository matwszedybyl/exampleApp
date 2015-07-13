//
//  ImageViewControllerTest.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 7/10/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <OCMock/OCMockObject.h>
#import "ImageViewController.h"

@interface ImageViewControllerTest : XCTestCase

@end

@implementation ImageViewControllerTest

ImageViewController *imageVC;


- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    imageVC = [storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
    [imageVC performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    imageVC = nil;
}

- (void)testImageExists{
    imageVC.timestamp = @"timestamp";
    [imageVC performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];

    XCTAssertEqual(@"timestamp", imageVC.timestamp);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
