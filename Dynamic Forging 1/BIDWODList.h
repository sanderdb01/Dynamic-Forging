//
//  BIDWODList.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 8/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDWODList : UITableViewController
<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSDictionary *names;
@property (strong, nonatomic) NSDictionary *savedNames;
@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSMutableDictionary *details;
@property (strong, nonatomic) NSArray *wodType;
@property (strong, nonatomic) NSArray *benchmarkGirls;
@property (strong, nonatomic) NSArray *theNewGirls;
@property (strong, nonatomic) NSArray *heroes;
@property (strong, nonatomic) NSArray *savedDFGWorkouts;
@property (copy, nonatomic) NSString *chosenWOD;
@property (strong, nonatomic) NSMutableDictionary *chosenDetails;




@end
