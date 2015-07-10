//
//  TableListVCTest.m
//  ExampleApp
//
//  Created by Mat Wszedybyl on 7/8/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <OCMock/OCMockObject.h>
#import "TableListViewController.h"
#import "Photo.h"
#import "PhotoViewCell.h"

@interface TableListViewControllerTest : XCTestCase

@end

@implementation TableListViewControllerTest

TableListViewController *tableListViewController;

- (void)setUp {
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    tableListViewController = [storyboard instantiateViewControllerWithIdentifier:@"TableListViewController"];
    [tableListViewController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    
}

- (void)tearDown {
    [super tearDown];
    tableListViewController = nil;
}

- (void)testTableIsVisible {
    
    XCTAssertFalse(tableListViewController.table.isHidden);
    XCTAssertEqual(0, [tableListViewController.tableData count]);

}

- (void)testTableDataDisplays {
    NSMutableArray *fakePhotoData = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < 4; i++){
        [fakePhotoData addObject:@"test"];
     }
    
    tableListViewController.tableData = fakePhotoData;
    NSInteger result = [tableListViewController tableView:[OCMArg any] numberOfRowsInSection:0];
    XCTAssertEqual(4,result);
    
}

- (void)testTableData {
//    NSMutableArray *fakePhotoData = [[NSMutableArray alloc]init];
//    id tableViewMock = OCMClassMock([UITableView class]);
//
//    
//    Photo *photo = [[Photo alloc]init];
//        photo.timestamp = @"timestamp";
//        [photo setValue:@"timestamp" forKey: @"timestamp"];
//        photo.url = @"url";
//
//        [fakePhotoData addObject:photo];
//    
//    tableListViewController.tableData = fakePhotoData;
//    id <UITableViewDelegate>tableDelegate = [tableListViewController.table delegate];
//
//    PhotoViewCell *cell = (PhotoViewCell *)[tableDelegate tableView:tableViewMock cellForRowAtIndexPath:0];
//    
//    XCTAssertEqual(@"",cell.timestampLabel.text);
    
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}


@end
