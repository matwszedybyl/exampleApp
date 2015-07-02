//
//  Photographer.h
//  ExampleApp
//
//  Created by Mat Wszedybyl on 6/29/15.
//  Copyright (c) 2015 Mat Wszedybyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photographer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;

@end
