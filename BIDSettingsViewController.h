//
//  BIDSettingsViewController.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 1/24/14.
//
//

#import <UIKit/UIKit.h>

@interface BIDSettingsViewController : UITableViewController

@property (strong, nonatomic) NSArray *defaultWorkouts;
@property (strong, nonatomic) NSMutableDictionary *savedWorkoutsDictionary;        // key: workout name, value: settings dictionary with key value of @"gym" and @"home", and values of @"on" and @"off"
@property (copy, nonatomic) NSDictionary *editedSelection;      // returned object from details page

@end
