//
//  BIDDFGeneratedController.h
//  Dynamic Forging 1
//
//  Created by David Sanders on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "BIDDFWorkout.h"
#import <UIKit/UIKit.h>

@interface BIDDFGeneratedController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (weak, nonatomic) IBOutlet UITextField *saveNameTextView;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *targetArea;
@property (copy, nonatomic) NSString *diffLvl;
@property (copy, nonatomic) NSString *results;
@property (strong, nonatomic) NSDictionary *saveDetails;
@property (weak, nonatomic) id delegate;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)textFieldStartEditing:(id)sender;
- (NSString *)dataFilePath;
- (NSString *)nameGenerator;

@end
