//
//  SimpleViewController.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/25/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
 
@interface TableListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)   NSArray *tableData;
@property (weak, nonatomic) IBOutlet UITableView *table;


@end
